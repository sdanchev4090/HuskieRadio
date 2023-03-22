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
    @IBOutlet weak var volumeButton: UIButton!
    
    //---------------------------------------------//
    
    private let songArtWebView: WKWebView = {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFill
        return webView
    }()
    var songNameWebView: WKWebView!
    
    var playPauseButton: UIButton!
    var volButton: UIButton!
    var volView: UIView!
    var volSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        
    }
    
        
    func setup() {
        // Play/Pause
        playPauseButton = UIButton(frame: CGRect(x: 311, y: 690, width: 188, height: 188))
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.addSubview(playPauseButton)
        
        // Song Art
        songArtWebView.frame = CGRect(x: 205, y: 120, width: 400, height: 400)
        view.addSubview(songArtWebView)
        
        // Song Name
        songNameWebView = WKWebView(frame: CGRect(x: 105, y: 590, width: 500, height: 100))
        view.addSubview(songNameWebView)
        
        // Test
//        let myVolSlider = MPVolumeView(frame: volView.bounds)
//        volView.addSubview(myVolSlider)
        
        
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
            let html2 = "<div style=\"bottom: 0;display: flex;height: 64px;left: 100;position: relative;right: 100;width: 100%;z-index: 1500;overflow: hidden;\"><iframe src=\"https://players.rcast.net/fixedbar5/68840\" frameborder=\"0\" scrolling=\"no\" allow=\"autoplay\" style=\"width: 100%;\"></iframe></div> <div style=\"overflow:hidden; height:0px; width:0px;\"><a href=\"https://www.rcast.net\" title=\"Internet Radio Hosting\">RCAST.NET</a></div>"
            
            DispatchQueue.main.async {
                  self.songArtWebView.loadHTMLString(html, baseURL: nil)
                self.songNameWebView.loadHTMLString(html2, baseURL: nil)
            }
            player?.volume = 0
            player?.play()
            
        } catch {
            print("Error Occurred")
        }
    }
    
    
    
    @objc func playPausePressed(_ sender: UIButton) {
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

