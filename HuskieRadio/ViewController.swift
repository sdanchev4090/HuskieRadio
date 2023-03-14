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
    
    var player: AVPlayer?
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    
    //---------------------------------------------//
    
    var songArtWebView: WKWebView!
    var playPause: UIButton!
    var volButton: UIButton!
    var volView: UIView!
    var volSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        
        print(AVAudioSession.sharedInstance().outputVolume)
    }
    
        
    func setup() {
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
        // Song Art
        songArtWebView = WKWebView(frame: CGRect(x: 205, y: 120, width: 400, height: 400))
        view.addSubview(songArtWebView)

        // Volume
        volView = UIView(frame: CGRect(x: 645, y: 913, width: 105, height: 105))
        volView.backgroundColor = .blue
        volView.layer.cornerRadius = 15
        volView.clipsToBounds = true
        
        // Volume Slider
        volSlider = UISlider(frame: CGRect(x: 697.5, y: 738, width: 300, height: 20))
        volSlider.center = CGPoint(x: 697.5 , y: 738)
        let rotate : CGAffineTransform = CGAffineTransformIdentity
        volSlider.transform = CGAffineTransformRotate(rotate, .pi*3/2)
        volSlider.tintColor = .systemOrange
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
            player?.play()
            player?.volume = 0
            
        } catch {
            print("Error Occurred")
        }
    }
    
    
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if player?.volume != 0 {
            // "Pause"
            player?.volume = 0
            // Play Icon
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
        } else {
            // "Play"
            player?.volume = 0.5
            // Pause Icon
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
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
    
    @IBAction func historyPressed(_ sender: UIButton) {
        // Allows to reference segue destination
//        let nvc = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
    }
}

