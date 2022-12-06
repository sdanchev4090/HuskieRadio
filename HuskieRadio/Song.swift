//
//  Song.swift
//  HuskieRadio
//
//  Created by Amanda Reyes on 12/6/22.
//

import Foundation
import UIKit

class song{
    var songName: String
    var artist: String
    var genre: String
    var album: String
    var songPic: UIImage?
    init(songName: String, artist: String, genre: String, album: String, songPic: UIImage?) {
        self.songName = songName
        self.artist = artist
        self.genre = genre
        self.album = album
        self.songPic = songPic
    }
}
