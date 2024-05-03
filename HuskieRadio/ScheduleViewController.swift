//
//  ScheduleViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 2/28/24.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var genre1_indicator: UIButton!
    @IBOutlet weak var genre1_timeLabel: UILabel!
    
    @IBOutlet weak var genre2_indicator: UIButton!
    @IBOutlet weak var genre2_timeLabel: UILabel!
    
    @IBOutlet weak var genre3_indicator: UIButton!
    @IBOutlet weak var genre3_timeLabel: UILabel!
    
    @IBOutlet weak var genre4_indicator: UIButton!
    @IBOutlet weak var genre4_timeLabel: UILabel!
    
    @IBOutlet weak var tabBarBG: UIView!
    
    @IBOutlet weak var infoBG: UIView!
    @IBOutlet weak var infoBGTop: NSLayoutConstraint!
    @IBOutlet weak var infoBGTrailing: NSLayoutConstraint!
//---------------------------------------------//


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
        genre1_indicator.tintColor = UIColor(named: "AccentName")
        genre2_indicator.tintColor = UIColor(named: "CellBackground")
        genre3_indicator.tintColor = UIColor(named: "CellBackground")
        genre4_indicator.tintColor = UIColor(named: "CellBackground")
        
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
        
    }

}
