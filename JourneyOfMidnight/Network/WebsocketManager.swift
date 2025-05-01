//
//  WebsocketManager.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

//
//  WebsocketManager.swift
//  JourneyOfMidnight
//  Created on 2025/4/27.
//

import Foundation
import Combine

enum ConnectionState {
    case disconnected
    case connecting
    case connected
}

enum WebSocketError: Error {
    case connectionFailed(Error)
    case messageSendFailed(Error)
    case invalidMessageFormat
    case connectionClosed
}

class WebsocketManager: ObservableObject {
    // Singleton instance !! 1 shared connection to websocket server
    static let shared = WebsocketManager()
    
    // Publishers for connection state and message events
    @Published var connectionState: ConnectionState = .disconnected
    private let messageSubject = PassthroughSubject<SocketMessage, Never>()
    var messagePublisher: AnyPublisher<SocketMessage, Never> {
        return messageSubject.eraseToAnyPublisher()
    }
    
    // URL session and task
    private var session: URLSession!
    private var webSocketTask: URLSessionWebSocketTask?
    
    // Server URL configuration
    private let serverBaseURL = "ws://\(apiDomain):4333"  // Use your server's WebSocket port
    
    // Cancel bag for subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    // Connect to WebSocket server
    func connect(endpoint: String = "/ws") {
        // Don't connect if already connected
        guard connectionState != .connected && connectionState != .connecting else {
            return
        }
        
        connectionState = .connecting
        
        let fullURL = "\(serverBaseURL)\(endpoint)"
        guard let url = URL(string: fullURL) else {
            print("Invalid WebSocket URL: \(fullURL)")
            connectionState = .disconnected
            return
        }
        
        webSocketTask = session.webSocketTask(with: url)
        
        // Setup message receiver
        receiveMessage()
        
        // Connect to server
        webSocketTask?.resume()
        connectionState = .connected
        
        // Setup ping to keep connection alive
        schedulePing()
    }
    
    // Disconnect from WebSocket server
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        connectionState = .disconnected
    }
    
    // Send a message to the server
    func send<T: Encodable>(message: T) -> AnyPublisher<Void, WebSocketError> {
        guard connectionState == .connected, let webSocketTask = webSocketTask else {
            return Fail(error: WebSocketError.connectionClosed).eraseToAnyPublisher()
        }
        
        return Just(message)
            .tryMap { message -> URLSessionWebSocketTask.Message in
                let data = try JSONEncoder().encode(message)
                let string = String(data: data, encoding: .utf8)!
                return .string(string)
            }
            .mapError { _ in WebSocketError.invalidMessageFormat }
            .flatMap { socketMessage -> AnyPublisher<Void, WebSocketError> in
                return Future<Void, WebSocketError> { promise in
                    webSocketTask.send(socketMessage) { error in
                        if let error = error {
                            promise(.failure(WebSocketError.messageSendFailed(error)))
                        } else {
                            promise(.success(()))
                        }
                    }
                }.eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    // Recursively receive messages
    private func receiveMessage() {
        guard let webSocketTask = webSocketTask, connectionState == .connected else {
            return
        }
        
        webSocketTask.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let message):   // Handle received message
                switch message {
                case .string(let text):
                    if let data = text.data(using: .utf8) {
                        do {
                            let socketMessage = try JSONDecoder().decode(SocketMessage.self, from: data)
                            print("Message received from websocket: \(socketMessage)")
                            self.messageSubject.send(socketMessage)
                        } catch {
                            print("Failed to decode message: \(error)")
                        }
                    }
                case .data(let data):
                    do {
                        let socketMessage = try JSONDecoder().decode(SocketMessage.self, from: data)
                        self.messageSubject.send(socketMessage)
                    } catch {
                        print("Failed to decode message: \(error)")
                    }
                @unknown default:
                    print("Unknown message type received")
                }
                
                // Continue receiving messages
                self.receiveMessage()
                
            case .failure(let error):
                print("WebSocket receive error: \(error)")
                self.connectionState = .disconnected
                
                // Try to reconnect after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                    self?.connect()
                }
            }
        }
    }
    
    // Schedule periodic ping to keep the connection alive
    private func schedulePing() {
        // Schedule ping every 30 seconds to keep connection alive
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) { [weak self] in
            guard let self = self, self.connectionState == .connected else { return }
            
            self.webSocketTask?.sendPing { error in
                if let error = error {
                    print("Ping failed: \(error)")
                    self.connectionState = .disconnected
                    
                    // Try to reconnect
                    self.connect()
                } else {
                    // Schedule next ping
                    self.schedulePing()
                }
            }
        }
    }
}

// MARK: - Socket Message Types

// Base message structure for socket communication
struct SocketMessage: Codable {
    let type: MessageType
    let payload: MessagePayload
}

// Message types
enum MessageType: String, Codable {
    case matchRequest = "match_request"
    case matchFound = "match_found"
    case matchCancelled = "match_cancelled"
    case gameStart = "game_start"
    case gameAction = "game_action"
    case gameEnd = "game_end"
    case error = "error"
    case ping = "ping"
    case pong = "pong"
}

// Payload structure
struct MessagePayload: Codable {
    private var values: [String: String]
    
    // Custom coding keys to access dynamic fields
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    // Access dynamic fields
    func value(for key: String) -> String? {
        return values[key]
    }
    
    // Initialize with key-value pairs
    init(values: [String: String]) {
        self.values = values
    }
    
    // Decodable implementation
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var values = [String: String]()
        for key in container.allKeys {
            let value = try container.decode(String.self, forKey: key)
            values[key.stringValue] = value
        }
        
        self.values = values
    }
    
    // Encodable implementation
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        for (key, value) in values {
            guard let codingKey = CodingKeys(stringValue: key) else {
                continue
            }
            try container.encode(value, forKey: codingKey)
        }
    }
}

// Helper for match request
struct MatchRequest {
    let heroClass: HeroClassName
    let level: Int
    
    func toSocketMessage() -> SocketMessage {
        let payload = MessagePayload(values: [
            "heroClass": heroClass.rawValue,
            "level": "\(level)"
        ])
        
        return SocketMessage(type: .matchRequest, payload: payload)
    }
}

// Helper for game actions
struct GameAction {
    let actionType: String
    let targetId: String?
    let skillId: String?
    
    func toSocketMessage() -> SocketMessage {
        var values: [String: String] = ["actionType": actionType]
        
        if let targetId = targetId {
            values["targetId"] = targetId
        }
        
        if let skillId = skillId {
            values["skillId"] = skillId
        }
        
        let payload = MessagePayload(values: values)
        return SocketMessage(type: .gameAction, payload: payload)
    }
}
