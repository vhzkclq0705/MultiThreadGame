//
//  MusicPlayer.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/20.
//

import AVFoundation

class MusicPlayer {
    var soundEffect = AVAudioPlayer()
    
    func playAudio(_ music: String) {
        stopAudio()
        guard let url = Bundle.main.url(
            forResource: music,
            withExtension: "mp3") else { return }
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            let sound = soundEffect
            
            sound.numberOfLoops = -1
            sound.prepareToPlay()
            sound.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopAudio() {
        soundEffect.stop()
    }
}
