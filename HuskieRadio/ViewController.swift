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
    
    @IBOutlet weak var playPauseButton: UIButton!
    var player: AVPlayer?
    @IBOutlet weak var currentSong: WKWebView!
    @IBOutlet weak var volumeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
    }

    func audioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: URL.init(string: urlHQ)!)
            
            // Current Song Art
            
        } catch {
        }
    }
    
    
    
    @IBAction func historyPressed(_ sender: Any) {
        //allows to reference segue destination
        let  nvc  = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
    }
    @IBAction func playPausePressed(_ sender: Any) {
        if player?.timeControlStatus == .playing {
            // Pause
            player?.pause()
            // Pause Icon
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
            // Shrink Image
            
            
        } else {
            // Play
            player?.play()
            // Play Icon
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            
            // Enlarge Image
            
        }
    }
    func animate(){
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.volumeView.alpha = 0.0
        })
    }
    
    @IBAction func volumePressed(_ sender: Any) {
        if volumeView.frame == CGRect(x: 635, y: 905, width: 125, height: 125){
            volumeView.frame = CGRect(x: 635, y: 660, width: 125, height: 370)
        } else {
            volumeView.frame = CGRect(x: 635, y: 905, width: 125, height: 125)
        }
    }
}

