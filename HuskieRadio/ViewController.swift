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
    
    @IBOutlet weak var currentSong: WKWebView!
    var player: AVPlayer?
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var volumeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        audioPlayer()
    }
    
        
    func audioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: URL.init(string: urlHQ)!)
            
            // Current Song Art HTML
            let html = "<!-- RCAST.NET - START EMBEDDED PLAYER --> <iframe width=\"500\" height=\"500\" src=\"https://players.rcast.net/artistimageonly/68840\" frameborder=\"0\" scrolling= \"no\" allow=\"autoplay\"></iframe> <div style=\"overflow:hidden; height:0px; width:0px;\"><a href=\"https://www.rcast.net\" title=\"Internet Radio Hosting\">RCAST.NET</a></div> <!-- RCAST.NET - END EMBEDDED PLAYER -->"
            currentSong.loadHTMLString(html, baseURL: nil)
            
        } catch {
        }
    }
    
    func setup() {
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
        volumeView.layer.cornerRadius = 15
        volumeView.clipsToBounds = true
    }
    
    
    
    @IBAction func historyPressed(_ sender: UIButton) {
        // Allows to reference segue destination
//        let nvc = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
    }
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if player?.timeControlStatus == .playing {
            // Pause
            player?.pause()
            // Play Icon
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            // Shrink Image
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.currentSong.frame = CGRect(x: 90,
                                                y: 90,
                                                width: self.view.frame.size.width-180,     // x times 2
                                                height: self.view.frame.size.width-180)     // x times 2
            })
            
        } else {
            // Play
            player?.play()
            // Pause Icon
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            // Enlarge Image
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.currentSong.frame = CGRect(x: 30,
                                                y: 30,
                                                width: self.view.frame.size.width-60,     // x times 2
                                                height: self.view.frame.size.width-60)     // x times 2
            })
        }
    }
    
    @IBAction func volumePressed(_ sender: Any) {
        // Volume Pop-up
        var inset : CGFloat = 10
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
}

