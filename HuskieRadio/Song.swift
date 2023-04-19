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
    var album: String
    var songArt: UIImage?
    init(titleArtist: String, album: String, songArt: UIImage?) {
        self.titleArtist = titleArtist
        self.album = album
        self.songArt = songArt
    }
}
