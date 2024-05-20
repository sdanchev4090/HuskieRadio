//
//  AboutViewController.swift
//  HuskieRadio
//
//  Created by Sava D (edu) on 5/20/24.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var contributorsView: UIView!
    @IBOutlet weak var contributorsViewTop: NSLayoutConstraint!
    @IBOutlet weak var contributorsViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var tabBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        // Do any additional setup after loading the view.
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
        
        // TabBar
        tabBarView.layer.cornerRadius = 30
        tabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Info BG
        contributorsView.layer.cornerRadius = 30
        contributorsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
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
            
            tabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                            .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            contributorsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                          .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            // Rounded Screen Spacing
            contributorsViewTop.constant = 22
            contributorsViewTrailing.constant = 21
            
        default:
            tabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            contributorsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
}
