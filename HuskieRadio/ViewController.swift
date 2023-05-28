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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabBarBG: UIView!
    @IBOutlet weak var recentsBG: UIView!
    
    @IBOutlet weak var recentsTableView: UITableView!
    
    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    let urlSongArt = URL(string: "https://artwork.rcast.net/68840")!
    let urlTitleArtist = URL(string: "https://status.rcast.net/68840")!
    let urlRecentsList = URL(string: "https://playlist.rcast.net/68840")!
    
    var currentSong = ""
    var recentsArray : [Song] = []
    
    var player: AVPlayer?
    
    //---------------------------------------------//
        
    var songTitle = UILabel()
    var playPauseButton = UIButton()
    var recentsButton = UIButton()
    var songArtImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        getData()
        
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
        playPauseButton = UIButton(frame: CGRect(x: 400, y: 485, width: 140, height: 135))
        playPauseButton.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        playPauseButton.tintColor = UIColor(named: "AccentColor")
//        let rect = CGRect(x: 400, y: 485, width: 140, height: 135)
//        let circle = UIBezierPath(ovalIn: rect)
        // circle color = white
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
    
    func getData() {
        URLSession.shared.dataTask(with: URLRequest(url: urlRecentsList)) { data, response, error in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
//                let songs = json[0] as! [String:Any]
//                print(songs)
                for song in json[1...10] {
                    let song_artist = song.object(forKey: "title") as! String
                    let saSplit = song_artist.split(separator: " - ", maxSplits: 1, omittingEmptySubsequences: true)
                    let title = String(saSplit[0])
                    let artist = String(saSplit[1])
                    
                    self.recentsArray.append(Song(title: title, artist: artist))
                }
                DispatchQueue.main.async {
                    self.recentsTableView.reloadData()
                }
            }
            let url = self.urlSongArt
            let link = self.urlTitleArtist
            DispatchQueue.global().async {
                var contents = URL(string: try! String(contentsOf: url))!
                var contents2 = try! String(contentsOf: link)
                if let data = try? Data(contentsOf: contents){
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.songArtImageView.image = image
                            self.songTitle.text = contents2
                            let time = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { time in
                                let newContents = URL(string: try! String(contentsOf: url))!
                                let newContents2 = try! String(contentsOf: link) 
                                if contents != newContents{
                                    contents = newContents
                                    contents2 = newContents2
                                    DispatchQueue.global().async {
                                        if let data = try? Data(contentsOf: contents) {
                                        if let image = UIImage(data: data){
                                            DispatchQueue.main.async {
                                                self.songArtImageView.image = image
                                                self.songTitle.text = contents2
                                            }
                                        }
                                    }
                                    }
                                } else {
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }.resume()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentsTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = recentsArray[indexPath.row].title
        content.secondaryText = recentsArray[indexPath.row].artist
        cell.contentConfiguration = content
        return cell
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

