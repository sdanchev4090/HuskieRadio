//
//  ViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 10/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playPauseButton: UIButton!
    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func historyPressed(_ sender: Any) {
        let  nvc  = SongHistoryViewController(nibName: "SongHistoryViewController", bundle: nil)
    }
    @IBAction func playPausePressed(_ sender: Any) {
    }
    
    @IBAction func volumePressed(_ sender: Any) {
    }
}

