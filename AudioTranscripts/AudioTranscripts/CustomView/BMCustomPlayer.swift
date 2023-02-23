//
//  BMCustomPlayer.swift
//  AudioTranscripts
//
//  Created by Tecorb Technologies on 16/02/23.
//

import Foundation
import BMPlayer

class BMCustomPlayer: BMPlayer {
    override func storyBoardCustomControl() -> BMPlayerControlView? {
        return BMPlayerCustomControlView()
    }
}
