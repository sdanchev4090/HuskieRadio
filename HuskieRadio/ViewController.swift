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
import SafariServices


class TitleArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var songArtImageView: UIImageView!

    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var tabBarBG: UIView!
    
    @IBOutlet weak var recentsHolder: UIView!
    @IBOutlet weak var recentsBG: UIView!
    @IBOutlet weak var recentsBGTop: NSLayoutConstraint!
    @IBOutlet weak var recentsBGTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var recentsLabelTop: NSLayoutConstraint!
    @IBOutlet weak var recentsTableView: UITableView!
    
    
    let urlHQ = "https://cast3.asurahosting.com/proxy/johnhers/stream"
    let urlLQ = "https://cast3.asurahosting.com/proxy/johnhers/stream2"
    
    let urlSongArt = URL(string: "https://artwork.rcast.net/68840")!
    let urlTitleArtist = URL(string: "https://status.rcast.net/68840")!
    let urlRecentsList = URL(string: "https://playlist.rcast.net/68840")!
    
    var SongArt : URL = URL(string: "https://artwork.rcast.net/68840")!
    var TitleArtist : String = ""
    var RecentsArray : [Song] = []
    
    var player: AVPlayer?
    
    var rowHeight: CGFloat = 0
//---------------------------------------------//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        setup()
        getData()
        controlCenterSetup()
        
        recentsTableView.delegate = self
        recentsTableView.dataSource = self
    }
    

//---------------------------------------------//
// MARK: - UI Setup
    
    func setup() {
        
        // TabBar
        tabBarBG.layer.cornerRadius = 30
        
        // Recently Played
        recentsBG.layer.cornerRadius = 30
        
        // Recently Played TableView
        /*
         Adjust top constraint based on the rowHeight times ten.
         If difference between current & (calculated - 1) is bigger than 0, then subtract that from constraint.
         */
//        rowHeight = CGFloat(ceilf( Float(recentsTableView.layer.frame.height) / 10 ))
//        let nHeight = rowHeight * 10 - 1
//        let cHeight = recentsTableView.layer.frame.height
//        let diff = nHeight - cHeight
//
//        if diff > 0 {
//            let const = recentsLabelTop.constant - diff
//            recentsLabelTop.constant = const
//        }
        
        recentsTableView.layer.cornerRadius = 25
        recentsTableView.layer.masksToBounds = true
        
        // Song Art ImageView
        songArtImageView.layer.cornerRadius = 25
        songArtImageView.layer.masksToBounds = true
        
        
        // Device Check
        switch UIDevice.modelName {
        case "iPad (10th generation)", "Simulator iPad (10th generation)",
            "iPad Air (3rd generation)",
            "iPad Air (4th generation)",
            "iPad Air (5th generation)",
            "iPad mini (5th generation)",
            "iPad mini (6th generation)",
            "iPad Pro (11-inch) (1st generation)",
            "iPad Pro (11-inch) (2nd generation)",
            "iPad Pro (11-inch) (3rd generation)",
            "iPad Pro (11-inch) (4th generation)":
            
            tabBarBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                            .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            recentsBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                             .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            // Rounded Screen Spacing
            recentsBGTop.constant = 22
            recentsBGTrailing.constant = 21
            recentsLabelTop.constant = 27
            
        default:
            tabBarBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            recentsBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        
    }
    
    
//---------------------------------------------//
// MARK: - Tab Bar
    
    @IBAction func ScheduleButtonPressed(_ sender: Any) {
    }
    
    @IBAction func AboutButtonPressed(_ sender: Any) {
        
    }
    
    
    
//---------------------------------------------//
// MARK: - Audio
    
    func audioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: URL.init(string: urlHQ)!)
            player?.volume = 1
            player?.play()

        } catch {
            print("Error Occurred")
        }
    }
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if playPauseButton.currentImage != UIImage(systemName: "play.circle.fill") {
            // "Pause"
            player?.volume = 0
            // Play Icon
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
        } else {
            // "Play"
            player?.volume = 1
            // Pause Icon
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    func controlCenterSetup() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let notifCenter = MPRemoteCommandCenter.shared()
        notifCenter.pauseCommand.isEnabled = true
        
        notifCenter.playCommand.addTarget { event1 in
            if self.player?.volume == 0 {
                self.player?.volume = 1
                return.success
            }
            return.commandFailed
        }
        notifCenter.pauseCommand.addTarget { event2 in
            if self.player?.volume == 1 {
                self.player?.volume = 0
                return.success
            }
            return.commandFailed
        }
    }
    
    
//---------------------------------------------//
// MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentsTableView.dequeueReusableCell(withIdentifier: "TitleArtistCell", for: indexPath) as! TitleArtistTableViewCell
        
        cell.artistLabel.text = RecentsArray[indexPath.row].artist
        cell.titleLabel.text = RecentsArray[indexPath.row].title
        switch indexPath.row {
        case 0:
            cell.numberLabel.text = "1"
        case 1:
            cell.numberLabel.text = "2"
        case 2:
            cell.numberLabel.text = "3"
        case 3:
            cell.numberLabel.text = "4"
        case 4:
            cell.numberLabel.text = "5"
        case 5:
            cell.numberLabel.text = "6"
        case 6:
            cell.numberLabel.text = "7"
        case 7:
            cell.numberLabel.text = "8"
        case 8:
            cell.numberLabel.text = "9"
        case 9:
            cell.numberLabel.text = "10"
        default:
            cell.numberLabel.text = "#"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight = CGFloat(ceilf( Float(recentsTableView.layer.frame.height) / 10 ))
//        print(rowHeight)
//        print(recentsLabelTop.constant)
//        print(recentsTableView.layer.frame.height)
        return rowHeight
    }
    
    
    // Touch Table to Search
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // add Try Catch statement to handle "Index out of range"
        
        let webtitle = RecentsArray[indexPath.row].title
        let webartist = RecentsArray[indexPath.row].artist
        print("\(indexPath.row)")
        
        if let url = URL(string: "https://google.com/search?q=\(webtitle) - \(webartist)") {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
        
    }
    

//---------------------------------------------//
// MARK: - getData
    
    func getData() {
        
        var newSongArt : URL = URL(string: "https://artwork.rcast.net/68840")!
        var newTitleArtist : String = ""
        var tempRecents : [Song] = RecentsArray
        var newRecents : [Song] = []
        
//---------------------------------------------//
// Pulling data
        
        DispatchQueue.global().async {
            self.SongArt = URL(string: try! String(contentsOf: self.urlSongArt))!
            self.TitleArtist = try! String(contentsOf: self.urlTitleArtist)
            if self.TitleArtist[self.TitleArtist.index(self.TitleArtist.endIndex, offsetBy: -1)] == Character("]") {
                self.TitleArtist.removeLast(7)
            }
            
            URLSession.shared.dataTask(with: URLRequest(url: self.urlRecentsList)) { data, response, error in
                guard let data = data else { return }
                if let json = try? JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
                    self.RecentsArray.removeAll()
                    tempRecents.removeAll()
                    for song in json[1...10] {
                        let song_artist = song.object(forKey: "title") as! String
                        let saSplit = song_artist.split(separator: " - ", maxSplits: 1, omittingEmptySubsequences: true)
                        var title = String(saSplit[1])
                        if title[title.index(title.endIndex, offsetBy: -1)] == Character("]") {
                            title.removeLast(7)
                        }
                        let artist = String(saSplit[0])
                        
                        self.RecentsArray.append(Song(title: title, artist: artist))
                    }
                }
            }.resume()
            
//---------------------------------------------//
// Set new data
            
            if let data = try? Data(contentsOf: self.SongArt) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        tempRecents = self.RecentsArray
                        self.songArtImageView.image = image
                        self.songTitle.text = self.TitleArtist
                        self.recentsTableView.reloadData()
                        
//---------------------------------------------//
                        
                        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { time in
                            DispatchQueue.global().async {
                                
                                // add Try Catch statement to handle "Index out of range"
                                
                                newSongArt = URL(string: try! String(contentsOf: self.urlSongArt))!
                                newTitleArtist = try! String(contentsOf: self.urlTitleArtist)
                                if newTitleArtist[newTitleArtist.index(newTitleArtist.endIndex, offsetBy: -1)] == Character("]") {
                                    newTitleArtist.removeLast(7)
                                }
                                
                                URLSession.shared.dataTask(with: URLRequest(url: self.urlRecentsList)) { data, response, error in
                                    guard let data = data else { return }
                                    if let json = try? JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
                                        newRecents.removeAll()
                                        for song in json[1...10] {
                                            let song_artist = song.object(forKey: "title") as! String
                                            let saSplit = song_artist.split(separator: " - ", maxSplits: 1, omittingEmptySubsequences: true)
                                            var title = String(saSplit[1])
                                            if title[title.index(title.endIndex, offsetBy: -1)] == Character("]") {
                                                title.removeLast(7)
                                            }
                                            let artist = String(saSplit[0])
                                            
                                            newRecents.append(Song(title: title, artist: artist))
                                        }
                                    }
                                }.resume()
                            }
                            
//---------------------------------------------//
// Compare & Set new data
                            
                            if tempRecents != newRecents {
                                self.SongArt = newSongArt
                                self.TitleArtist = newTitleArtist
                                self.RecentsArray = newRecents
                                DispatchQueue.global().async {
                                    if let data = try? Data(contentsOf: self.SongArt) {
                                        if let image = UIImage(data: data){
                                            DispatchQueue.main.async {
                                                self.songArtImageView.image = image
                                                self.songTitle.text = self.TitleArtist
                                                self.recentsTableView.reloadData()
                                            }
                                        }
                                    }
                                }
                                
                            } else {
                                newRecents.removeAll()
                                return
                            }
                            
//---------------------------------------------//
                            
                        }
                    }
                }
            }
        }
    }

    
}



//---------------------------------------------//
// MARK: - Device Checker

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String {
            switch identifier {
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad13,18", "iPad13,19":                        return "iPad (10th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad14,3", "iPad14,4":                          return "iPad Pro (11-inch) (4th generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "iPad14,5", "iPad14,6":                          return "iPad Pro (12.9-inch) (6th generation)"
            case "i386", "x86_64", "arm64":                       return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return identifier
            }
        }

        return mapToDevice(identifier: identifier)
    }()

}
