//
//  SongHistoryViewController.swift
//  HuskieRadio
//
//  Created by Amanda Reyes on 12/19/22.
//

import UIKit

class SongHistoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    var songs : [song] = [song(songName: "Placeholder", artist: "placeholder artist", genre: "placeholder", album: "placeholderalbum", songPic: nil)]

    @IBOutlet weak var songsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songsTable.dataSource = self
        songsTable.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songsTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = songs[indexPath.row].songName
        content.secondaryText =  songs[indexPath.row].artist
        cell.contentConfiguration = content
        return cell
    }

}
