//
//  WebsocketManager.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/4/27.
//

import Foundation
import Combine

@MainActor
class WebSocketManager: ObservableObject {
    // MARK: - Properties
    static let shared = WebSocketManager()
    private let serverURL = URL(string: "ws://10.2.201.208:4333/ws")!
    private var webSocketTask: URLSessionWebSocketTask?
    private var pingTask: Task<Void, Never>?
    private var receiveTask: Task<Void, Never>?
    private var session: URLSession!
    
    // workplace IP: 10.2.201.208
    // phone IP: 206.189.40.30:4333
    
    // Publishers
    @Published var isConnected: Bool = false
    @Published var receivedMessages: [String] = []
    
    // MARK: - Initialization
    private init() {
        session = URLSession(configuration: .default)
    }
    
    // MARK: - Connection Management
    func connect() {
        guard webSocketTask == nil else { return }
        do {
            webSocketTask = session.webSocketTask(with: serverURL)
            webSocketTask?.resume()
            isConnected = true
            
            startReceivingMessages()
            startPingTask()
            
            print("WebSocket attempting connection to: \(serverURL.absoluteString)")
        } catch {
            print("WebSocket connection initialization error: \(error)")
            isConnected = false
        }
    }
    
    func disconnect() {
        pingTask?.cancel()
        pingTask = nil
        
        receiveTask?.cancel()
        receiveTask = nil
        
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        isConnected = false
        
        print("WebSocket disconnected")
    }
    
    // MARK: - Message Handling
    func sendMessage(_ message: String) async throws {
        guard let webSocketTask = webSocketTask, isConnected else {
            print("Cannot send message: WebSocket not connected")
            throw WebSocketError.notConnected
        }
        
        let message = URLSessionWebSocketTask.Message.string(message)
        try await webSocketTask.send(message)
    }
    
    func sendGameAction(_ action: GameAction) async throws -> GameResponse {
        // Encode the action to JSON
        let encoder = JSONEncoder()
        let data = try encoder.encode(action)
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw WebSocketError.encodingFailed
        }
        
        // Send the message
        try await sendMessage(jsonString)
        
        // Wait for a response
        // In a real implementation, you'd want to correlate requests and responses
        // using something like a request ID
        return try await withTimeout(seconds: 10) {
            var response: GameResponse?
            
            while response == nil {
                if let message = await self.waitForNextMessage() {
                    let decoder = JSONDecoder()
                    if let data = message.data(using: .utf8) {
                        do {
                            response = try decoder.decode(GameResponse.self, from: data)
                        } catch {
                            print("Failed to decode response: \(error)")
                        }
                    }
                }
            }
            
            return response!
        }
    }
    
    private func waitForNextMessage() async -> String? {
        let currentCount = receivedMessages.count
        
        // Wait for a new message
        while receivedMessages.count == currentCount {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
            if Task.isCancelled { return nil }
        }
        
        return receivedMessages.last
    }
    
    private func startReceivingMessages() {
        receiveTask = Task {
            await receiveMessages()
        }
    }
    
    private func receiveMessages() async {
        guard let webSocketTask = webSocketTask else { return }
        
        do {
            while !Task.isCancelled {
                let message = try await webSocketTask.receive()
                
                switch message {
                case .string(let text):
                    receivedMessages.append(text)
                    print("Received message: \(text)")
                    
                case .data(let data):
                    if let string = String(data: data, encoding: .utf8) {
                        receivedMessages.append(string)
                        print("Received data message: \(string)")
                    }
                    
                @unknown default:
                    break
                }
            }
        } catch {
            print("WebSocket receive error: \(error)")
            await handleError(error)
        }
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: Error) async {
        isConnected = false
        await reconnectAfterDelay()
    }
    
    private func reconnectAfterDelay() async {
        disconnect()
        
        try? await Task.sleep(nanoseconds: 3_000_000_000) // 3 seconds
        
        if !Task.isCancelled {
            connect()
        }
    }
    
    // MARK: - Ping to Keep Connection Active
    private func startPingTask() {
        pingTask = Task {
            while !Task.isCancelled {
                await pingServer()
                try? await Task.sleep(nanoseconds: 30_000_000_000) // 30 seconds
            }
        }
    }
    
    private func pingServer() async {
        do {
            try await webSocketTask?.sendPing(pongReceiveHandler: {_ in
                
            })
        } catch {
            print("WebSocket ping failed: \(error)")
            await handleError(error)
        }
    }
    
    // Helper function for timeouts
    private func withTimeout<T>(seconds: Double, operation: @escaping () async throws -> T) async throws -> T {
        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await operation()
            }
            
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
                throw WebSocketError.timeout
            }
            
            // Return the first completed result, which will either be the operation
            // or the timeout error
            return try await group.next()!
        }
    }
}

// MARK: - Custom Errors
enum WebSocketError: Error {
    case notConnected
    case encodingFailed
    case timeout
}

struct FindMatchAction: Codable {
    let action: String
    let payload: FindMatchPayload
}

struct FindMatchPayload: Codable {
    let id: String
    let username: String
}



// MARK: - Game Data Models
struct GameAction: Codable {
    let type: String
    let payload: GameActionPayload
}

struct GameActionPayload: Codable {
    let actionType: String
    let targetId: String?
    let selectedOption: Int?
    // Add other fields as needed for your game actions
}

struct GameResponse: Codable {
    let success: Bool
    let message: String
    let data: GameResponseData?
}

struct GameResponseData: Codable {
    let gameState: String
    let heroes: [HeroResponse]?
    let enemies: [HeroResponse]?
    let events: [EventResponse]?
    // Add other fields as needed
}

struct HeroResponse: Codable, Identifiable {
    let id: String
    let name: String
    let heroClass: String
    let level: Int
    let health: Int
    let skills: [SkillResponse]
    // Add other fields as needed
}

struct SkillResponse: Codable, Identifiable {
    let id: String
    let name: String
    let power: Int
    // Add other fields as needed
}

struct EventResponse: Codable, Identifiable {
    let id: String
    let type: String
    let description: String
    let options: [OptionResponse]?
    // Add other fields as needed
}

struct OptionResponse: Codable, Identifiable {
    let id: String
    let text: String
    let effectType: String
    let effectValue: Int
    // Add other fields as needed
}
