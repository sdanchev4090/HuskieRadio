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
            
            let controller = AVPlayerViewController()
            controller.player = player
            controller.showsPlaybackControls = false
            self.addChild(controller)
            let screenSize = UIScreen.main.bounds.size
            let videoFrame = CGRect(x: 0, y: 130, width: screenSize.width, height: (screenSize.height - 130) / 2)
            controller.view.frame = videoFrame
            self.view.addSubview(controller.view)
            
            player?.play()
        } catch {
        }
    }
    
    
    
    @IBAction func historyPressed(_ sender: Any) {
        let nvc = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
    }
    @IBAction func playPausePressed(_ sender: Any) {
    }
    
    @IBAction func volumePressed(_ sender: Any) {
    }
}

