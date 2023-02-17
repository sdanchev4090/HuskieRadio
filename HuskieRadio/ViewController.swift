//
//  ViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 10/28/22.
//

import UIKit
import AVKit
import WebKit

class ViewController: UIViewController {
    
    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    var player: AVPlayer?
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var volumeView: UIView!
    @IBOutlet weak var volumeSlider: UISlider!
    
    //---------------------------------------------//
    
    var songArtWebView: WKWebView!
    var playPause: UIButton!
    var volButton: UIButton!
    var volView: UIButton!
    var volSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
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
            
        } catch {
            print("Error Occurred")
        }
    }
    
    func setup() {
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
        //Song Art
        songArtWebView = WKWebView(frame: CGRect(x: 205, y: 120, width: 400, height: 400))
        view.addSubview(songArtWebView)
        
        //Volume
        volumeView.layer.cornerRadius = 15
        volumeView.clipsToBounds = true
        
        
    }
    
    
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        let html = "<!-- RCAST.NET - START EMBEDDED PLAYER --> <iframe width=\"500\" height=\"500\" src=\"https://players.rcast.net/artistimageonly/68840\" frameborder=\"0\" scrolling= \"no\" allow=\"autoplay\"></iframe> <div style=\"overflow:hidden; height:0px; width:0px;\"><a href=\"https://www.rcast.net\" title=\"Internet Radio Hosting\">RCAST.NET</a></div> <!-- RCAST.NET - END EMBEDDED PLAYER -->"
        DispatchQueue.main.async {
              self.songArtWebView.loadHTMLString(html, baseURL: nil)
        }
        
        if player?.volume != 0 {
            // "Pause"
            player?.volume = 0
            // Play Icon
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            // Shrink Image
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0, animations: {
                    self.songArtWebView.frame = CGRect(x: 205, y: 120, width: 400, height: 400)
    //                                                CGRect(x: 90,
    //                                                y: 90,
    //                                                width: self.view.frame.size.width-180,     // x times 2
    //                                                height: self.view.frame.size.width-180)     // x times 2
                })
            }
            
        } else {
            // "Play"
            player?.volume = 0.5
            // Pause Icon
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            // Enlarge Image
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0, animations: {
                    self.songArtWebView.frame = CGRect(x: 155, y: 70, width: 500, height: 500)
    //                                                CGRect(x: 30,
    //                                                y: 30,
    //                                                width: self.view.frame.size.width-60,     // x times 2
    //                                                height: self.view.frame.size.width-60)     // x times 2
                })
            }
        }
    }
    
    @IBAction func volumePressed(_ sender: Any) {
        // Volume Pop-up
        let inset : CGFloat = 10
        let volStFrame = CGRect(x: volumeButton.frame.minX + inset,
                                y: volumeButton.frame.minY+8,
                                width: volumeButton.frame.width-(inset*2),
                                height: volumeButton.frame.width-(inset*2))
        let volOpenFrame = CGRect(x: volStFrame.minX,
                                  y: volStFrame.minY-(playPauseButton.frame.height+(85*2)),
                                  width: volStFrame.width,
                                  height: playPauseButton.frame.height+(90*2))
        
        // UIView expands + reveals volume slider
        if volumeView.frame == volStFrame {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.volumeView.frame = volOpenFrame
            }
            
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.volumeView.frame = volStFrame
            }
        }
    }
    
    @IBAction func historyPressed(_ sender: UIButton) {
        // Allows to reference segue destination
//        let nvc = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
    }
}

