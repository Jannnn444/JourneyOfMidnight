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
    
    @Published var isMusicEnabled = true {
        didSet {
            handleMusicEnabledChange()
        }
    }
    
    @Published var isSoundEffectsEnabled = true
    @Published var musicVolume: Float = 0.7 {
        didSet {
            backgroundMusicPlayer?.volume = musicVolume
        }
    }
    @Published var soundEffectVolume: Float = 0.8
    
    private var currentMusicFileName: String?
    private var wasPlayingBeforeDisable = false
    
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
    
    // MARK: - Music Enable/Disable Handling
    
    private func handleMusicEnabledChange() {
        if isMusicEnabled {
            // If music was playing before being disabled, resume it
            if wasPlayingBeforeDisable, let fileName = currentMusicFileName {
                resumeOrStartBackgroundMusic(fileName: fileName)
            }
        } else {
            // Remember if music was playing before disabling
            wasPlayingBeforeDisable = backgroundMusicPlayer?.isPlaying ?? false
            pauseBackgroundMusic()
        }
    }
    
    // MARK: - Background Music
    
    func playBackgroundMusic(fileName: String, fileExtension: String = "mp3") {
        currentMusicFileName = fileName
        
        guard isMusicEnabled else {
            wasPlayingBeforeDisable = true
            return
        }
        
        // Don't restart if the same music is already playing
        if backgroundMusicPlayer?.isPlaying == true && currentMusicFileName == fileName {
            return
        }
        
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
    
    private func resumeOrStartBackgroundMusic(fileName: String, fileExtension: String = "mp3") {
        if backgroundMusicPlayer != nil && currentMusicFileName == fileName {
            // Resume existing player
            resumeBackgroundMusic()
        } else {
            // Start new music
            playBackgroundMusic(fileName: fileName, fileExtension: fileExtension)
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        backgroundMusicPlayer = nil
        currentMusicFileName = nil
        wasPlayingBeforeDisable = false
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
    
    // MARK: - Toggle Methods (for backwards compatibility)
    
    func toggleMusic() {
        isMusicEnabled.toggle()
    }
    
    func toggleSoundEffects() {
        isSoundEffectsEnabled.toggle()
    }
    
    // MARK: - Initialization Helper
    
    func initializeBackgroundMusic(fileName: String = "Maple") {
        if currentMusicFileName == nil {
            playBackgroundMusic(fileName: fileName)
        }
    }
    
    func playSystemSound() {
        AudioServicesPlaySystemSound(1000)
    }

}

