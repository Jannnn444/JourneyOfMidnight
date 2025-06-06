//
//  MusicManager.swift
//  JourneyOfMidnight
//
//  Created by Jan    on 2025/6/5.
//
//
//  MusicManager.swift
//  JourneyOfMidnight
//
//  Created by Jan on 2025/6/6.
//

import Foundation
import AVFoundation

class MusicManager: ObservableObject {
    static let shared = MusicManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectPlayers: [String: AVAudioPlayer] = [:]
    
    @Published var isMusicEnabled = true
    @Published var isSoundEffectsEnabled = true
    @Published var musicVolume: Float = 0.7
    @Published var soundEffectVolume: Float = 0.8
    
    private init() {
        setupAudioSession()
    }
    
    // MARK: - Audio Session Setup
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    // MARK: - Background Music
    
    func playBackgroundMusic(fileName: String, fileExtension: String = "mp3") {
        guard isMusicEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Could not find background music file: \(fileName).\(fileExtension)")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1 // Loop infinitely
            backgroundMusicPlayer?.volume = musicVolume
            backgroundMusicPlayer?.play()
        } catch {
            print("Could not play background music: \(error)")
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
        guard isMusicEnabled else { return }
        backgroundMusicPlayer?.play()
    }
    
    func setMusicVolume(_ volume: Float) {
        musicVolume = max(0.0, min(1.0, volume))
        backgroundMusicPlayer?.volume = musicVolume
    }
    
    // MARK: - Sound Effects
    
    func playSoundEffect(_ fileName: String, fileExtension: String = "mp3") {
        guard isSoundEffectsEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Could not find sound effect file: \(fileName).\(fileExtension)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = soundEffectVolume
            player.play()
            
            // Store reference to prevent deallocation
            soundEffectPlayers[fileName] = player
            
            // Remove reference after playing
            DispatchQueue.main.asyncAfter(deadline: .now() + player.duration) {
                self.soundEffectPlayers.removeValue(forKey: fileName)
            }
        } catch {
            print("Could not play sound effect: \(error)")
        }
    }
    
    func setSoundEffectVolume(_ volume: Float) {
        soundEffectVolume = max(0.0, min(1.0, volume))
    }
    
    // MARK: - Game-Specific Sound Effects
    
    func playBattleStartSound() {
        playSoundEffect("battle_start")
    }
    
    func playVictorySound() {
        playSoundEffect("victory")
    }
    
    func playDefeatSound() {
        playSoundEffect("defeat")
    }
    
    func playCardSelectSound() {
        playSoundEffect("card_select")
    }
    
    func playPurchaseSound() {
        playSoundEffect("purchase")
    }
    
    func playSkillCastSound() {
        playSoundEffect("skill_cast")
    }
    
    func playSystemSound() {
        AudioServicesPlaySystemSound(1000)
    }
    
    // MARK: - Settings Management
    
    func toggleMusic() {
        isMusicEnabled.toggle()
        if isMusicEnabled {
            // Resume current background music if it was playing
            resumeBackgroundMusic()
        } else {
            pauseBackgroundMusic()
        }
    }
    
    func toggleSoundEffects() {
        isSoundEffectsEnabled.toggle()
    }
}
