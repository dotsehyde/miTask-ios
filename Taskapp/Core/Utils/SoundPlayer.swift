//
//  SoundPlayer.swift
//  Taskapp
//
//  Created by Benjamin on 06/09/2022.
//

import Foundation
import AVFoundation

var player: AVPlayer?

func playSound(fileName: String, type: String) {
    if let path = Bundle.main.path(forResource: fileName, ofType: type) {
        do {
            player = AVPlayer(url: URL(fileURLWithPath: path))
            try player?.play()
        } catch {
            print("Could not play sound file")
        }

    }
}
