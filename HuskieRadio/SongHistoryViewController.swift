//
//  SongHistoryViewController.swift
//  HuskieRadio
//
//  Created by Amanda Reyes on 12/19/22.
//

import UIKit
import WebKit
class SongHistoryViewController: UIViewController {
    @IBOutlet weak var recentlyPlayed: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        let html = "<!-- RCAST.NET - START EMBEDDED PLAYER --> <iframe width=\"100%\" height=\"610\" src=\"https://players.rcast.net/playlisthistory4/68840\" frameborder=\"0\" scrolling=\"yes\" allow=\"autoplay\"></iframe> <div style=\"overflow:hidden; height:0px; width:0px;\"><a href=\"https://www.rcast.net\" title=\"Internet Radio Hosting\">RCAST.NET</a></div> <!-- RCAST.NET - END EMBEDDED PLAYER -->"
        DispatchQueue.main.async {
            self.recentlyPlayed.loadHTMLString(html, baseURL: nil)
        }
    }
    override func viewDidLoad() {
    }

}
