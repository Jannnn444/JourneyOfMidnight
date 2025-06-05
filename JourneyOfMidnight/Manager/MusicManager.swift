//
//  MusicManager.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/5.
//

import Foundation
import SwiftUI
import AVFoundation

class MusicManager: ObservableObject {
    static let shared = MusicManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectPlayer:AVAudioPlayer?
    
    @Published var isMusicEnabled = true
    @Published var musicVolume: Float = 0.5
    @Published var soundEffectEnabled = true
    @Published var soundEffectVolumn: Float = 0.7
    
    private init() {
        setupAudioSession()
    }
    private func setupAudioSession() {
           do {
               try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)
           } catch {
               print("Failed to set up audio session: \(error)")
           }
       }
    func playBacjgroundMusic(fileName: String, fileType: String = "mp3") {
        guard isMusicEnabled else { return }
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("Could not finf file \(fileName).\(fileType)")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = musicVolume
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music: \(error)")
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        backgroundMusicPlayer = nil
    }
    
    func pauseBackgroundMusic() {
        backgroundMusicPlayer?.pause()
    }
       
    func resumeBackgroundMusic() {
        backgroundMusicPlayer?.play()
    }
    
    func setMusicVolume(_ volume: Float) {
        musicVolume = volume
        backgroundMusicPlayer?.volume = volume
    }
    
}
