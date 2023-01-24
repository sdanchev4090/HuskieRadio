//
//  ViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 10/28/22.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    @IBOutlet weak var playPauseButton: UIButton!
    var player: AVPlayer?
    
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
        let nvc = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
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
    
    @IBAction func volumePressed(_ sender: Any) {
    }
}

