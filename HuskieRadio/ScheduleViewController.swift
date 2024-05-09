//
//  ScheduleViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 2/28/24.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var genre1_indicator: UIView!
    @IBOutlet weak var genre1_timeLabel: UILabel!
    
    @IBOutlet weak var genre2_indicator: UIView!
    @IBOutlet weak var genre2_timeLabel: UILabel!
    
    @IBOutlet weak var genre3_indicator: UIView!
    @IBOutlet weak var genre3_timeLabel: UILabel!
    
    @IBOutlet weak var genre4_indicator: UIView!
    @IBOutlet weak var genre4_timeLabel: UILabel!
    
    @IBOutlet weak var tabBarBG: UIView!
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var currentGenreLabel: UILabel!
    
    @IBOutlet weak var infoBG: UIView!
    @IBOutlet weak var infoBGTop: NSLayoutConstraint!
    @IBOutlet weak var infoBGTrailing: NSLayoutConstraint!
//---------------------------------------------//

    override func viewWillAppear(_ animated: Bool) {
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setup() {
        
        // Genre Indicators
        genre1_indicator.layer.cornerRadius = 3
        genre2_indicator.layer.cornerRadius = 3
        genre3_indicator.layer.cornerRadius = 3
        genre4_indicator.layer.cornerRadius = 3
        
        // TabBar
        tabBarBG.layer.cornerRadius = 30
        tabBarBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Info BG
        infoBG.layer.cornerRadius = 30
        infoBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
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
            
            infoBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                             .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            // Rounded Screen Spacing
            infoBGTop.constant = 22
            infoBGTrailing.constant = 21
            
        default:
            tabBarBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            infoBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        
        
        // Clock
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            let time = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            
            let current = formatter.string(from: time)
            self.clockLabel.text = current
            
            // Genre
            let hour = DateFormatter()
            hour.dateFormat = "hh a"
            
            switch hour.string(from: time) {
            case "12 AM":
                self.genre2_timeLabel.textColor = UIColor(named: "AccentColor")
                self.genre2_indicator.backgroundColor = UIColor(named: "AccentColor")
                self.currentGenreLabel.text = "Midnight Blues"
                
            case "1 AM","2 AM":
                self.genre3_timeLabel.textColor = UIColor(named: "AccentColor")
                self.genre3_indicator.backgroundColor = UIColor(named: "AccentColor")
                self.currentGenreLabel.text = "Overnight Jazz"
            
            case "3 AM","4 AM","5 AM":
                self.genre4_timeLabel.textColor = UIColor(named: "AccentColor")
                self.genre4_indicator.backgroundColor = UIColor(named: "AccentColor")
                self.currentGenreLabel.text = "Classical Café"
                
            default:
                self.genre1_timeLabel.textColor = UIColor(named: "AccentColor")
                self.genre1_indicator.backgroundColor = UIColor(named: "AccentColor")
                self.currentGenreLabel.text = "Hits & Greats"
            }
            
        }
        
    }
    
    
    func currentGenre() {
        
    }

}
