//
//  ViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 10/28/22.
//

import UIKit
import AVKit
import MediaPlayer
import WebKit
import SafariServices


class TitleArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabBarBG: UIView!
    @IBOutlet weak var recentsBG: UIView!
    
    @IBOutlet weak var recentsTableView: UITableView!
    
    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    let urlSongArt = URL(string: "https://artwork.rcast.net/68840")!
    let urlTitleArtist = URL(string: "https://status.rcast.net/68840")!
    let urlRecentsList = URL(string: "https://playlist.rcast.net/68840")!
    
    var SongArt : URL = URL(string: "https://artwork.rcast.net/68840")!
    var TitleArtist : String = ""
    var RecentsArray : [Song] = []
    
    var player: AVPlayer?
    
//---------------------------------------------//
        
    var songTitle = UILabel()
    var playPauseButton = UIButton()
    var playPauseBG = UIView()
    var recentsButton = UIButton()
    var songArtImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        getData()
        controlCenterSetup()
        
        recentsTableView.delegate = self
        recentsTableView.dataSource = self
    }
    
        
    func setup() {
        // TabBar
        tabBarBG.layer.cornerRadius = 30
        tabBarBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Recently Played
        recentsBG.layer.cornerRadius = 30
        recentsBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        // Song Name
        songTitle.frame = CGRect(x: 92, y: 636, width: 410, height: 29)
        songTitle.font = .boldSystemFont(ofSize: 24)
        view.addSubview(songTitle)
       
        // Song Art Image View
        songArtImageView.frame = CGRect(x: 82, y: 165, width: 430, height: 430)
        songArtImageView.layer.cornerRadius = 25
        songArtImageView.layer.masksToBounds = true
        view.addSubview(songArtImageView)
        
        // Play/Pause
        playPauseBG.frame = CGRect(x: 411, y: 495, width: 118, height: 115)
        playPauseBG.backgroundColor = UIColor(named: "MainBackground")
        playPauseBG.tintColor = .white
        playPauseBG.layer.cornerRadius = playPauseBG.layer.bounds.width / 2
        playPauseBG.layer.masksToBounds = true
        view.addSubview(playPauseBG)
        
        playPauseButton = UIButton(frame: CGRect(x: 400, y: 485, width: 140, height: 135))
        playPauseButton.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        playPauseButton.tintColor = UIColor(named: "AccentColor")
        view.addSubview(playPauseButton)
        
        // Recently Played Table View
        recentsTableView.layer.cornerRadius = 25
        recentsTableView.layer.masksToBounds = true
    }
    
    func audioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: URL.init(string: urlHQ)!)
            player?.volume = 1
            player?.play()

        } catch {
            print("Error Occurred")
        }
    }
    
    func controlCenterSetup() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let notifCenter = MPRemoteCommandCenter.shared()
        notifCenter.pauseCommand.isEnabled = true
        
        notifCenter.playCommand.addTarget { event1 in
            if self.player?.volume == 0 {
                self.player?.volume = 1
                return .success
            }
            return.commandFailed
        }
        notifCenter.pauseCommand.addTarget { event2 in
            if self.player?.volume == 1 {
                self.player?.volume = 0
                return.success
            }
            return.commandFailed
        }
    }
    
    
//---------------------------------------------//
// TableView
    
    // Touch Table to Search
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        let webtitle = RecentsArray[indexPath.row].title
        let webartist = RecentsArray[indexPath.row].artist
        
        if let url = URL(string: "https://google.com/search?q=\(webtitle) - \(webartist)") {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentsTableView.dequeueReusableCell(withIdentifier: "TitleArtistCell", for: indexPath) as! TitleArtistTableViewCell
        
        cell.artistLabel.text = RecentsArray[indexPath.row].artist
        cell.titleLabel.text = RecentsArray[indexPath.row].title
        return cell
    }
    
//---------------------------------------------//
//---------------------------------------------//
    
    func getData() {
        
        var newSongArt : URL = URL(string: "https://artwork.rcast.net/68840")!
        var newTitleArtist : String = ""
        var tempRecents : [Song] = RecentsArray
        var newRecents : [Song] = []
        
//---------------------------------------------//
// Pulling data
        
        DispatchQueue.global().async {
            self.SongArt = URL(string: try! String(contentsOf: self.urlSongArt))!
            self.TitleArtist = try! String(contentsOf: self.urlTitleArtist)
            if self.TitleArtist[self.TitleArtist.index(self.TitleArtist.endIndex, offsetBy: -1)] == Character("]") {
                self.TitleArtist.removeLast(7)
            }
            
            URLSession.shared.dataTask(with: URLRequest(url: self.urlRecentsList)) { data, response, error in
                guard let data = data else { return }
                if let json = try? JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
                    self.RecentsArray.removeAll()
                    tempRecents.removeAll()
                    for song in json[1...10] {
                        let song_artist = song.object(forKey: "title") as! String
                        let saSplit = song_artist.split(separator: " - ", maxSplits: 1, omittingEmptySubsequences: true)
                        var title = String(saSplit[1])
                        if title[title.index(title.endIndex, offsetBy: -1)] == Character("]") {
                            title.removeLast(7)
                        }
                        let artist = String(saSplit[0])
                        
                        self.RecentsArray.append(Song(title: title, artist: artist))
                    }
                }
            }.resume()
            
//---------------------------------------------//
// Set new data
            
            if let data = try? Data(contentsOf: self.SongArt) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        tempRecents = self.RecentsArray
                        self.songArtImageView.image = image
                        self.songTitle.text = self.TitleArtist
                        self.recentsTableView.reloadData()
                        
//---------------------------------------------//
                        
                        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { time in
                            DispatchQueue.global().async {
                                newSongArt = URL(string: try! String(contentsOf: self.urlSongArt))!
                                newTitleArtist = try! String(contentsOf: self.urlTitleArtist)
                                if newTitleArtist[newTitleArtist.index(newTitleArtist.endIndex, offsetBy: -1)] == Character("]") {
                                    newTitleArtist.removeLast(7)
                                }
                                
                                URLSession.shared.dataTask(with: URLRequest(url: self.urlRecentsList)) { data, response, error in
                                    guard let data = data else { return }
                                    if let json = try? JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
                                        newRecents.removeAll()
                                        for song in json[1...10] {
                                            let song_artist = song.object(forKey: "title") as! String
                                            let saSplit = song_artist.split(separator: " - ", maxSplits: 1, omittingEmptySubsequences: true)
                                            var title = String(saSplit[1])
                                            if title[title.index(title.endIndex, offsetBy: -1)] == Character("]") {
                                                title.removeLast(7)
                                            }
                                            let artist = String(saSplit[0])
                                            
                                            newRecents.append(Song(title: title, artist: artist))
                                        }
                                    }
                                }.resume()
                            }
                            
//---------------------------------------------//
// Compare & Set new data
                            
                            if tempRecents != newRecents {
                                self.SongArt = newSongArt
                                self.TitleArtist = newTitleArtist
                                self.RecentsArray = newRecents
                                DispatchQueue.global().async {
                                    if let data = try? Data(contentsOf: self.SongArt) {
                                        if let image = UIImage(data: data){
                                            DispatchQueue.main.async {
                                                self.songArtImageView.image = image
                                                self.songTitle.text = self.TitleArtist
                                                self.recentsTableView.reloadData()
                                            }
                                        }
                                    }
                                }
                                
                            } else {
                                newRecents.removeAll()
                                return
                            }
                            
//---------------------------------------------//
                            
                        }
                    }
                }
            }
        }
    }
    

    
    @objc func playPausePressed() {
        if playPauseButton.currentBackgroundImage != UIImage(systemName: "play.circle.fill") {
            // "Pause"
            player?.volume = 0
            // Play Icon
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
        } else {
            // "Play"
            player?.volume = 1
            // Pause Icon
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
}


//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//
//
//}
