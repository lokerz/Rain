//
//  MusicPlayer.swift
//  Rain
//
//  Created by Ridwan Abdurrasyid on 18/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import AVFoundation


class MusicPlayer :  NSObject{
    static let shared = MusicPlayer()
    
    var playerDic: [String : AVAudioPlayer] = [:]

    func addPlayer(_ soundName : String, _ soundDic : String){
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {return}
    
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        
            let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            playerDic[soundDic] = player
            if let player = playerDic[soundDic]{
                player.volume = 0
                player.numberOfLoops = -1
                player.play()
            }
        
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func fadeInSound(_ soundDic : String, _ volume : Float){
        playerDic[soundDic]!.setVolume(volume, fadeDuration: 2)
    }

    func fadeOutSound(_ soundDic : String){
        playerDic[soundDic]!.setVolume(0, fadeDuration: 2)
    }
}
