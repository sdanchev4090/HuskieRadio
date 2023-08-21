//
//  Song.swift
//  HuskieRadio
//
//  Created by Amanda Reyes on 12/6/22.
//

import Foundation
import UIKit

class Song: Equatable {
    
    var title: String
    var artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title && lhs.artist == rhs.artist
    }
}
