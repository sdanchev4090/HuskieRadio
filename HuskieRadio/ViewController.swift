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
    private let songNameWebView: WKWebView = {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFill
        return webView
    }()
    private let testSongArtWebView: WKWebView = {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFill
        return webView
    }()

    
    var playPauseButton: UIButton!
    var recentsButton: UIButton!
    var volButton: UIButton!
    var volView: UIView!
    var volSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        getData()
        
    }
    
        
    func setup() {
        // Song Art
        songArtWebView.frame = CGRect(x: 205, y: 120, width: 400, height: 400)
        songArtWebView.layer.cornerRadius = 25
        songArtWebView.clipsToBounds = true
        view.addSubview(songArtWebView)
        
        // Test Song Art
        testSongArtWebView.frame = CGRect(x: 205, y: 120, width: 400, height: 400)
        testSongArtWebView.layer.cornerRadius = 25
        testSongArtWebView.clipsToBounds = true
        view.addSubview(testSongArtWebView)
        
        // Song Name
        songNameWebView.frame = CGRect(x: 105, y: 590, width: 500, height: 100)
        view.addSubview(songNameWebView)
        
        // Play/Pause
        playPauseButton.frame = CGRect(x: 308, y: 660, width: 190, height: 188)
        
        playPauseButton.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        view.addSubview(playPauseButton)
        
        
        // Recents
//        recentsButton = UIButton(frame: CGRect(x: 50, y: 905, width: 125, height: 125))
//        recentsButton.setBackgroundImage(UIImage(systemName: "music.note.list"), for: .normal)
//        view.addSubview(recentsButton)
        
        // Volume
//        volButton = UIButton(frame: CGRect(x: 635, y: 905, width: 125, height: 125))
//        volButton.setBackgroundImage(UIImage(systemName: "volume.2.fill"), for: .normal)
//        view.addSubview(volButton)
        
//        // Volume Slider
//        volView = UIView(frame: CGRect(x: 645, y: 913, width: 105, height: 105))
//        volView.backgroundColor = .blue
//        volView.layer.cornerRadius = 15
//        volView.clipsToBounds = true
//
//        volSlider = UISlider(frame: CGRect(x: 697.5, y: 738, width: 300, height: 20))
//        volSlider.center = CGPoint(x: 697.5 , y: 738)
//        let rotate : CGAffineTransform = CGAffineTransformIdentity
//        volSlider.transform = CGAffineTransformRotate(rotate, .pi*3/2)
//        volSlider.tintColor = .systemOrange
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
                self.currentSong = "\(songs["title"]!)"
                print(self.currentSong)
                // keep looping until data chnages
            }
            let url = self.urlSongArt
            DispatchQueue.main.async {
                let contents = URL(string: try! String(contentsOf: url))!
                self.testSongArtWebView.load(NSURLRequest(url: contents) as URLRequest)
            }
        }.resume()
        
    }
    
    
    @objc func playPausePressed() {
        if (player?.volume)! > 0 {
            // "Pause"
            player?.volume = 0
            // Play Icon
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
        } else {
            // "Play"
            player?.volume = 1
            // Pause Icon
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.ciircle.fill"), for: .normal)
        }
    }
    
    @objc func volumePressed() {
        // Volume Pop-up
        let inset : CGFloat = 10
        let volStFrame = CGRect(x: volButton.frame.minX + inset,
                                y: volButton.frame.minY+8,
                                width: volButton.frame.width-(inset*2),
                                height: volButton.frame.width-(inset*2))
        let volOpenFrame = CGRect(x: volStFrame.minX,
                                  y: volStFrame.minY-(playPauseButton.frame.height+(85*2)),
                                  width: volStFrame.width,
                                  height: playPauseButton.frame.height+(90*2))
        
        // UIView expands + reveals volume slider
        if volView.frame == volStFrame {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.volView.frame = volOpenFrame
            }

        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.volView.frame = volStFrame
            }
        }
    }
    
    @objc func recentsPressed() {
        // Allows to reference segue destination
    }
}

