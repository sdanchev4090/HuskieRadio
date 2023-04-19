//
//  Song.swift
//  HuskieRadio
//
//  Created by Amanda Reyes on 12/6/22.
//

import Foundation
import UIKit

class Song{
    var titleArtist: String
    var songArt: UIImage?
    init(titleArtist: String, songArt: UIImage?) {
        self.titleArtist = titleArtist
        self.songArt = songArt
    }
}
