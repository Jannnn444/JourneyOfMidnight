//
//  WebsocketManager.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import Foundation
import Combine

// MARK: - WebSocket Manager
@MainActor
class WebSocketManager: NSObject, ObservableObject {
    // MARK: - Singleton
    static let shared = WebSocketManager()
    
    // MARK: - Configuration
    private let serverURL = URL(string: "ws://10.2.201.208:4333/ws")!
    private let heartbeatInterval: TimeInterval = 30.0
    private let queueKeepAliveInterval: TimeInterval = 25.0
    private let reconnectDelay: TimeInterval = 3.0
    
    // MARK: - Properties
    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession!
    private var heartbeatTimer: Timer?
    private var queueKeepAliveTimer: Timer?
    private var messageSubscriptions = Set<AnyCancellable>()
    
    // MARK: - Published Properties
    @Published var connectionState: ConnectionState = .disconnected
    @Published var queueState: QueueState = .notInQueue
    @Published var lastError: WebSocketError?
    @Published var receivedMessages: [GameMessage] = []
    
    // MARK: - Player Info
    private let playerId = UUID().uuidString
    private var playerUsername: String = "Player"
    
    // MARK: - Computed Properties
    var isConnected: Bool {
        connectionState == .connected
    }
    
    var isInQueue: Bool {
        queueState == .searching || queueState == .waitingForMatch
    }
    
    // MARK: - Initialization
    private override init() {
        super.init()
        setupURLSession()
    }
    
    private func setupURLSession() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    // MARK: - Public Connection Methods
    func connect() {
        guard webSocketTask == nil else {
            print("WebSocket already connected or connecting")
            return
        }
        
        connectionState = .connecting
        webSocketTask = urlSession.webSocketTask(with: serverURL)
        webSocketTask?.resume()
        
        startReceivingMessages()
        print("WebSocket attempting connection to: \(serverURL.absoluteString)")
    }
    
    func disconnect() {
        stopAllTimers()
        
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        
        connectionState = .disconnected
        queueState = .notInQueue
        
        print("WebSocket disconnected")
    }
    
    // MARK: - Queue Management
    func findMatch(username: String) {
        guard isConnected else {
            lastError = .notConnected
            return
        }
        
        self.playerUsername = username
        queueState = .searching
        
        let action = FindMatchAction(
            action: "find_match",
            payload: FindMatchPayload(
                id: playerId,
                username: username
            )
        )
        
        Task {
            await sendMessage(action)
            startQueueKeepAlive()
        }
    }
    
    func cancelQueue() {
        guard isInQueue else { return }
        
        let action = QueueAction(
            action: "cancel_queue",
            payload: BasicPayload(
                id: playerId,
                username: playerUsername
            )
        )
        
        Task {
            await sendMessage(action)
        }
        
        stopQueueKeepAlive()
        queueState = .notInQueue
    }
    
    // MARK: - Game Actions
    func sendGameAction<T: Codable>(_ action: T) async throws {
        guard isConnected else {
            throw WebSocketError.notConnected
        }
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(action)
            
            guard let jsonString = String(data: data, encoding: .utf8) else {
                throw WebSocketError.encodingFailed
            }
            
            let message = URLSessionWebSocketTask.Message.string(jsonString)
            try await webSocketTask?.send(message)
            
            print("Sent game action: \(jsonString)")
            
        } catch {
            print("Failed to send game action: \(error)")
            throw WebSocketError.sendFailed(error)
        }
    }
    
    func sendTurnAction(eventChoice: String, gameState: GameStatePayload) {
        let action = TurnAction(
            action: "turn_action",
            payload: TurnPayload(
                id: playerId,
                username: playerUsername,
                eventChoice: eventChoice,
                gameState: gameState,
                timestamp: Date()
            )
        )
        
        Task {
            try await sendGameAction(action)
        }
    }
    
    func sendHeroSelection(heroes: [Hero]) {
        let heroData = heroes.map { HeroData(
            name: $0.heroClass.name.rawValue,
            level: $0.heroClass.level,
            skills: $0.skills.map { $0.name }
        )}
        
        let action = HeroSelectionAction(
            action: "hero_selection",
            payload: HeroSelectionPayload(
                id: playerId,
                username: playerUsername,
                heroes: heroData,
                timestamp: Date()
            )
        )
        
        Task {
            try await sendGameAction(action)
        }
    }
    
    // MARK: - Private Message Handling
    private func sendMessage<T: Codable>(_ message: T) async {
        do {
            try await sendGameAction(message)
        } catch {
            print("Failed to send message: \(error)")
            lastError = error as? WebSocketError ?? .unknown(error)
        }
    }
    
    private func startReceivingMessages() {
        Task {
            await receiveMessages()
        }
    }
    
    private func receiveMessages() async {
        guard let webSocketTask = webSocketTask else { return }
        
        while !Task.isCancelled && connectionState != .disconnected {
            do {
                let message = try await webSocketTask.receive()
                await handleReceivedMessage(message)
            } catch {
                print("WebSocket receive error: \(error)")
                await handleConnectionError(error)
                break
            }
        }
    }
    
    private func handleReceivedMessage(_ message: URLSessionWebSocketTask.Message) async {
        var messageString: String?
        
        switch message {
        case .string(let text):
            messageString = text
        case .data(let data):
            messageString = String(data: data, encoding: .utf8)
        @unknown default:
            print("Unknown message type received")
            return
        }
        
        guard let messageString = messageString else {
            print("Failed to decode message")
            return
        }
        
        print("Received message: \(messageString)")
        await processMessage(messageString)
    }
    
    private func processMessage(_ messageString: String) async {
        guard let data = messageString.data(using: .utf8) else {
            print("Failed to convert message to data")
            return
        }
        
        do {
            let gameMessage = try JSONDecoder().decode(GameMessage.self, from: data)
            receivedMessages.append(gameMessage)
            await handleGameMessage(gameMessage)
        } catch {
            print("Failed to decode game message: \(error)")
            // Try to decode as a simple message
            if let simpleMessage = try? JSONDecoder().decode(SimpleMessage.self, from: data) {
                print("Received simple message: \(simpleMessage.message)")
            }
        }
    }
    
    private func handleGameMessage(_ message: GameMessage) async {
        switch message.action {
        case "match_found":
            queueState = .matchFound
            stopQueueKeepAlive()
            print("Match found!")
            
        case "queue_position":
            if let position = Int(message.payload.id) {
                queueState = .searching
                print("Queue position: \(position)")
            }
            
        case "game_start":
            queueState = .notInQueue
            print("Game started!")
            
        case "turn_update":
            print("Turn update received")
            
        case "game_end":
            queueState = .notInQueue
            print("Game ended")
            
        case "error":
            lastError = .serverError(message.payload.username)
            print("Server error: \(message.payload.username)")
            
        case "pong":
            print("Received pong")
            
        default:
            print("Unknown action received: \(message.action)")
        }
    }
    
    // MARK: - Connection Management
    private func handleConnectionError(_ error: Error) async {
        connectionState = .disconnected
        queueState = .notInQueue
        lastError = .connectionLost(error)
        
        stopAllTimers()
        
        // Auto-reconnect after delay
        try? await Task.sleep(nanoseconds: UInt64(reconnectDelay * 1_000_000_000))
        
        if !Task.isCancelled {
            connect()
        }
    }
    
    // MARK: - Timer Management
    private func startHeartbeat() {
        stopHeartbeat()
        
        heartbeatTimer = Timer.scheduledTimer(withTimeInterval: heartbeatInterval, repeats: true) { [weak self] _ in
            Task {
                do {
                    await self?.sendHeartbeat()
                }
            }
        }
    }
    
    private func stopHeartbeat() {
        heartbeatTimer?.invalidate()
        heartbeatTimer = nil
    }
    
    private func startQueueKeepAlive() {
        stopQueueKeepAlive()
        
        queueKeepAliveTimer = Timer.scheduledTimer(withTimeInterval: queueKeepAliveInterval, repeats: true) { [weak self] _ in
            Task {
                do {
                    await self?.sendQueueKeepAlive()
                }
              
            }
        }
    }
    
    private func stopQueueKeepAlive() {
        queueKeepAliveTimer?.invalidate()
        queueKeepAliveTimer = nil
    }
    
    private func stopAllTimers() {
        stopHeartbeat()
        stopQueueKeepAlive()
    }
    
    private func sendHeartbeat() async {
        let heartbeat = HeartbeatAction(
            action: "heartbeat",
            payload: BasicPayload(
                id: playerId,
                username: playerUsername
            )
        )
        
        await sendMessage(heartbeat)
    }
    
    func sendQueueKeepAlive() async {
        guard isInQueue else {
            stopQueueKeepAlive()
            return
        }
        
        let keepAlive = QueueKeepAliveAction(
            action: "queue_keepalive",
            payload: TimestampPayload(
                id: playerId,
                username: playerUsername,
                timestamp: Date()
            )
        )
        
        await sendMessage(keepAlive)
    }
}

// MARK: - URLSessionWebSocketDelegate
extension WebSocketManager: URLSessionWebSocketDelegate {
    nonisolated func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        Task { @MainActor in
            connectionState = .connected
            startHeartbeat()
            print("WebSocket connected successfully")
        }
    }
    
    nonisolated func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        Task { @MainActor in
            connectionState = .disconnected
            queueState = .notInQueue
            stopAllTimers()
            
            let reasonString = reason.flatMap { String(data: $0, encoding: .utf8) } ?? "Unknown"
            print("WebSocket closed with code: \(closeCode.rawValue), reason: \(reasonString)")
        }
    }
}

// MARK: - Enums
enum ConnectionState {
    case disconnected
    case connecting
    case connected
}

enum QueueState {
    case notInQueue
    case searching
    case waitingForMatch
    case matchFound
}

enum WebSocketError: Error, LocalizedError {
    case notConnected
    case encodingFailed
    case sendFailed(Error)
    case connectionLost(Error)
    case serverError(String)
    case timeout
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .notConnected:
            return "WebSocket is not connected"
        case .encodingFailed:
            return "Failed to encode message"
        case .sendFailed(let error):
            return "Failed to send message: \(error.localizedDescription)"
        case .connectionLost(let error):
            return "Connection lost: \(error.localizedDescription)"
        case .serverError(let message):
            return "Server error: \(message)"
        case .timeout:
            return "Operation timed out"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

// MARK: - Message Models
struct GameMessage: Codable {
    let action: String
    let payload: MessagePayload
}

struct MessagePayload: Codable {
    let id: String
    let username: String
}

struct SimpleMessage: Codable {
    let message: String
}

// MARK: - Action Models
struct FindMatchAction: Codable {
    let action: String
    let payload: FindMatchPayload
}

struct FindMatchPayload: Codable {
    let id: String
    let username: String
}

struct QueueAction: Codable {
    let action: String
    let payload: BasicPayload
}

struct HeartbeatAction: Codable {
    let action: String
    let payload: BasicPayload
}

struct QueueKeepAliveAction: Codable {
    let action: String
    let payload: TimestampPayload
}

struct TurnAction: Codable {
    let action: String
    let payload: TurnPayload
}

struct HeroSelectionAction: Codable {
    let action: String
    let payload: HeroSelectionPayload
}

// MARK: - Payload Models
struct BasicPayload: Codable {
    let id: String
    let username: String
}

struct TimestampPayload: Codable {
    let id: String
    let username: String
    let timestamp: Date
}

struct TurnPayload: Codable {
    let id: String
    let username: String
    let eventChoice: String
    let gameState: GameStatePayload
    let timestamp: Date
}

struct HeroSelectionPayload: Codable {
    let id: String
    let username: String
    let heroes: [HeroData]
    let timestamp: Date
}

struct GameStatePayload: Codable {
    let gold: Int
    let currentEvent: String
    let turnNumber: Int?
}

struct HeroData: Codable {
    let name: String
    let level: Int
    let skills: [String]
}
