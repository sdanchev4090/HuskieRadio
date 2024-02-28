//
//  ScheduleViewController.swift
//  HuskieRadio
//
//  Created by Sava Danchev on 2/28/24.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var tabBarBG: UIView!
    @IBOutlet weak var infoBG: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        tabBarBG.layer.cornerRadius = 30
        tabBarBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Info BG
        infoBG.layer.cornerRadius = 30
        infoBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

}
