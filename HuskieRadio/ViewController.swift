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

class ViewController: UIViewController {
    
    @IBOutlet weak var tabBarBG: UIView!
    @IBOutlet weak var recentsBG: UIView!
    
    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    let urlSongArt = URL(string: "https://artwork.rcast.net/68840")!
    let urlTitleArtist = URL(string: "https://status.rcast.net/68840")!
    let urlRecentsList = URL(string: "https://playlist.rcast.net/68840")!
    
    var currentSong = ""
    
    var player: AVPlayer?
    
    //---------------------------------------------//
    
    private let songArtWebView: WKWebView = {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFill
        return webView
    }()
    private let testSongArtWebView: WKWebView = {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFill
        return webView
    }()

    

    var songTitle = UILabel(frame: CGRect(x: 92, y: 620, width: 410, height: 29))
    var playPauseButton = UIButton()
    var recentsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        getData()
        
    }
    
        
    func setup() {
        // TabBar
        tabBarBG.layer.cornerRadius = 30
        tabBarBG.clipsToBounds = true
        
        // Recently Played
        recentsBG.layer.cornerRadius = 30
        recentsBG.clipsToBounds = true
        
        // Song Art
        songArtWebView.frame = CGRect(x: 82, y: 165, width: 400, height: 400)
        songArtWebView.layer.cornerRadius = 25
        songArtWebView.clipsToBounds = false
        view.addSubview(songArtWebView)
        
        // Test Song Art
//        testSongArtWebView.frame = CGRect(x: 92, y: 566, width: 400, height: 400)
//        testSongArtWebView.layer.cornerRadius = 25
//        testSongArtWebView.clipsToBounds = true
//        view.addSubview(testSongArtWebView)
        
        // Song Name
        songTitle.font = .boldSystemFont(ofSize: 24)
        view.addSubview(songTitle)
        
        // Play/Pause
        playPauseButton = UIButton(frame: CGRect(x: 397, y: 485, width: 140, height: 140))
        
        playPauseButton.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        
        view.addSubview(playPauseButton)
        
        
    }
    
    func audioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: URL.init(string: urlHQ)!)
            
            // Current Song Art HTML
            let html = "<!-- RCAST.NET - START EMBEDDED PLAYER --> <iframe width=\"500\" height=\"500\" src=\"https://players.rcast.net/artistimageonly/68840\" frameborder=\"0\" scrolling= \"no\" allow=\"autoplay\"></iframe> <div style=\"overflow:hidden; height:0px; width:0px;\"><a href=\"https://www.rcast.net\" title=\"Internet Radio Hosting\">RCAST.NET</a></div> <!-- RCAST.NET - END EMBEDDED PLAYER -->"
            
            DispatchQueue.main.async {
                self.songArtWebView.loadHTMLString(html, baseURL: nil)
            }
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
                let songs = json[0] as! [String:Any]
                print(songs)
                // from position 1-11 for table view
                // keep looping until data chnages
            }
            let url = self.urlSongArt
                        let link = self.urlTitleArtist
                        DispatchQueue.main.async {
                            let contents = URL(string: try! String(contentsOf: url))!
                            let contents2 = try! String(contentsOf: link)
                            self.testSongArtWebView.load(NSURLRequest(url: contents) as URLRequest)
                            self.songTitle.text = contents2
                            
                        }
        }.resume()
        
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
    
 
    
    @objc func recentsPressed() {
        // Allows to reference segue destination
    }
}

