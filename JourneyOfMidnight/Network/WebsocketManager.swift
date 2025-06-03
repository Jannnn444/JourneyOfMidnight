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
    
    // MARK: - 單例模式
    static let shared = WebSocketManager()
    
    // MARK: - 配置常數
    private let serverURL = URL(string: "ws://10.2.201.208:4333/ws")!
    private let heartbeatInterval: TimeInterval = 30.0
    private let queueKeepAliveInterval: TimeInterval = 25.0
    private let reconnectDelay: TimeInterval = 3.0
    
    // workplace IP: 10.2.201.208
    // phone IP: 206.189.40.30:4333
    
    // MARK: - 核心屬性
    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession!
    private var messageSubscriptions = Set<AnyCancellable>()
    
    private let playerId = UUID().uuidString
    private var playerUsername: String = "Player"
    
    // MARK: - 狀態管理
    @Published var connectionState: ConnectionState = .disconnected
    @Published var queueState: QueueState = .notInQueue
    @Published var lastError: WebSocketError?
    @Published var receivedMessages: [GameMessage] = []
    
    // MARK: - 配對狀態管理
    @Published var queueStatus: QueueStatus = .waiting
    @Published var currentPlayers: [String] = []
    @Published var gameId: String? = nil
    @Published var isMatchReady: Bool = false
    
    enum QueueStatus {
        case waiting
        case found
        case starting
        case inGame
    }
    
    // MARK: - 計時器管理
    private var heartbeatTimer: Timer?
    private var queueKeepAliveTimer: Timer?
    
    // MARK: - 計算屬性
    var isConnected: Bool {
        connectionState == .connected
    }
    
    var isInQueue: Bool {
        queueState == .searching || queueState == .waitingForMatch
    }
    
    // MARK: - 初始化
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
    
    // MARK: - === 第一層：底層連接管理 ===
    
    /// 建立 WebSocket 連接
    func connect() {
        connectionState = .connecting
        webSocketTask = urlSession.webSocketTask(with: serverURL)
        webSocketTask?.resume()
        
        startReceivingMessages()
        print("WebSocket attempting connection to: \(serverURL.absoluteString)")
    }
    
    /// 斷開 WebSocket 連接
    func disconnect() {
        stopAllTimers()
        
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        
        connectionState = .disconnected
        queueState = .notInQueue
        resetQueueStatus()
        
        print("WebSocket disconnected")
    }
    
    /// 重置隊列狀態
    private func resetQueueStatus() {
        queueStatus = .waiting
        currentPlayers = []
        gameId = nil
        isMatchReady = false
    }
    
    /// 處理連接錯誤和自動重連
    private func handleConnectionError(_ error: Error) async {
        connectionState = .disconnected
        queueState = .notInQueue
        lastError = .connectionLost(error)
        
        stopAllTimers()
        resetQueueStatus()
        
        // Auto-reconnect after delay
        try? await Task.sleep(nanoseconds: UInt64(reconnectDelay * 1_000_000_000))
        
        if !Task.isCancelled {
            connect()
        }
    }
    
    // MARK: - === 第二層：底層消息收發 ===
    
    /// 底層消息發送（會拋出錯誤）
    private func sendGameAction<T: Codable>(_ action: T) async throws {
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
    
    /// 開始接收消息
    private func startReceivingMessages() {
        Task {
            await receiveMessages()
        }
    }
    
    /// 持續接收消息的循環
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
    
    /// 處理接收到的原始消息
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
    
    /// 解析玩家列表
    private func parsePlayerList(from message: String) {
        let lines = message.components(separatedBy: "\n")
        var players: [String] = []
        
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedLine.hasPrefix("PlayerOf") {
                let player = String(trimmedLine.dropFirst(8)) // Remove "Player: "
                players.append(player)
            }
        }
        
        DispatchQueue.main.async {
            self.currentPlayers = players
            print("Updated player list: \(players)")
            self.checkMatchReadiness()
        }
    }
    
    /// 解析遊戲信息
    private func parseGameInfo(from message: String) {
        if let range = message.range(of: "gameId: ") {
            let gameIdStart = range.upperBound
            let remainingMessage = message[gameIdStart...]
            
            if let lineEnd = remainingMessage.firstIndex(of: "\n") {
                let extractedGameId = String(remainingMessage[..<lineEnd]).trimmingCharacters(in: .whitespacesAndNewlines)
                DispatchQueue.main.async {
                    self.gameId = extractedGameId
                    print("Updated game ID: \(extractedGameId)")
                    self.checkMatchReadiness()
                }
            } else {
                // If no newline found, take the rest of the string
                let extractedGameId = String(remainingMessage).trimmingCharacters(in: .whitespacesAndNewlines)
                DispatchQueue.main.async {
                    self.gameId = extractedGameId
                    print("Updated game ID: \(extractedGameId)")
                    self.checkMatchReadiness()
                }
            }
        }
    }
    
    /// 檢查配對是否準備就緒
    private func checkMatchReadiness() {
        let playersReady = currentPlayers.count >= 2
        let gameIdReady = gameId != nil && !gameId!.isEmpty
        
        if playersReady && gameIdReady && !isMatchReady {
            isMatchReady = true
            queueStatus = .found
            queueState = .matchFound
            print("🎮 Match is ready! Players: \(currentPlayers.count), GameID: \(gameId ?? "none")")
            
            // Optional: Automatically transition after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.queueStatus = .starting
            }
        }
    }
    
    // MARK: - === 第三層：消息封裝和錯誤處理 ===
    
    /// 安全的消息發送（不會拋出錯誤）
    private func sendMessage<T: Codable>(_ message: T) async {
        do {
            try await sendGameAction(message)
        } catch {
            print("Failed to send message: \(error)")
            lastError = error as? WebSocketError ?? .unknown(error)
        }
    }
    
    /// 處理和解析消息內容
    private func processMessage(_ messageString: String) async {
        // First try to parse as queue status message (plain text)
        if messageString.contains("players:") || messageString.contains("gameId:") {
            await handleQueueStatusMessage(messageString)
            return
        }
        
        // Try to parse as JSON message
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
            } else {
                print("Raw message: \(messageString)")
            }
        }
    }
    
    /// 處理隊列狀態消息
    private func handleQueueStatusMessage(_ message: String) async {
        print("Processing queue status message")
        
        // Parse player list
        if message.contains("players:") {
            parsePlayerList(from: message)
        }
        
        // Parse game info
        if message.contains("gameId:") {
            parseGameInfo(from: message)
        }
    }
    
    /// 處理解析後的遊戲消息
    private func handleGameMessage(_ message: GameMessage) async {
        switch message.action {
        case "match_found":
            queueState = .matchFound
            queueStatus = .found
            stopQueueKeepAlive()
            print("Match found!")
            
        case "queue_position":
            if let position = Int(message.payload.id) {
                queueState = .searching
                print("Queue position: \(position)")
            }
            
        case "game_start":
            queueState = .notInQueue
            queueStatus = .inGame
            print("Game started!")
            
        case "turn_update":
            print("Turn update received")
            
        case "game_end":
            queueState = .notInQueue
            queueStatus = .waiting
            resetQueueStatus()
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
    
    // MARK: - === 第四層：業務邏輯功能 ===
    
    /// 尋找遊戲匹配
    func findMatch(username: String) {
        guard isConnected else {
            lastError = .notConnected
            return
        }
        
        self.playerUsername = username
        queueState = .searching
        resetQueueStatus()
        
        let action = FindMatchAction(
            action: "find_match",
            payload: FindMatchPayload(id: playerId, username: username)
        )
        
        Task {
            await sendMessage(action)
            startQueueKeepAlive()
        }
    }
    
    /// 取消排隊
    func cancelQueue() {
        guard isInQueue else { return }
        
        let action = QueueAction(
            action: "cancel_queue",
            payload: BasicPayload(id: playerId, username: playerUsername)
        )
        
        Task {
            await sendMessage(action)
        }
        
        stopQueueKeepAlive()
        queueState = .notInQueue
        resetQueueStatus()
    }
    
    /// 確認開始遊戲
    func confirmGameStart() {
        guard queueStatus == .found || queueStatus == .starting else { return }
        
        queueStatus = .inGame
        queueState = .notInQueue
        stopQueueKeepAlive()
        
        print("Game confirmed to start with gameId: \(gameId ?? "unknown")")
    }
    
    /// 發送回合動作
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
            await sendMessage(action)
        }
    }
    
    /// 發送英雄選擇
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
            await sendMessage(action)
        }
    }
    
    // MARK: - === 第五層：輔助功能（計時器和心跳）===
    
    /// 發送心跳包
    private func sendHeartbeat() async {
        let heartbeat = HeartbeatAction(
            action: "heartbeat",
            payload: BasicPayload(id: playerId, username: playerUsername)
        )
        
        await sendMessage(heartbeat)
    }
    
    /// 發送隊列保活信號
    private func sendQueueKeepAlive() async {
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
    
    /// 啟動心跳計時器
    private func startHeartbeat() {
        stopHeartbeat()
        
        heartbeatTimer = Timer.scheduledTimer(withTimeInterval: heartbeatInterval, repeats: true) { [weak self] _ in
            Task {
                await self?.sendHeartbeat()
            }
        }
    }
    
    /// 停止心跳計時器
    private func stopHeartbeat() {
        heartbeatTimer?.invalidate()
        heartbeatTimer = nil
    }
    
    /// 啟動隊列保活計時器
    private func startQueueKeepAlive() {
        stopQueueKeepAlive()
        
        queueKeepAliveTimer = Timer.scheduledTimer(withTimeInterval: queueKeepAliveInterval, repeats: true) { [weak self] _ in
            Task {
                await self?.sendQueueKeepAlive()
            }
        }
    }
    
    /// 停止隊列保活計時器
    private func stopQueueKeepAlive() {
        queueKeepAliveTimer?.invalidate()
        queueKeepAliveTimer = nil
    }
    
    /// 停止所有計時器
    private func stopAllTimers() {
        stopHeartbeat()
        stopQueueKeepAlive()
    }
}

// MARK: - === URLSessionWebSocketDelegate ===
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
            resetQueueStatus()
            
            let reasonString = reason.flatMap { String(data: $0, encoding: .utf8) } ?? "Unknown"
            print("WebSocket closed with code: \(closeCode.rawValue), reason: \(reasonString)")
        }
    }
}

// MARK: - === 枚舉定義 ===
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

// MARK: - === 數據模型 ===

// 消息模型
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

// 動作模型
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


// Payload Model
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
