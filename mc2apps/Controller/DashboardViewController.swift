//
//  DashboardViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 22/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var dashboardLabel: UILabel! {
        didSet{
//            dashboardLabel.font = UIFont(name: "SFProRounded-Bold", size: 36)
            dashboardLabel.textColor = UIColor(red: 0.2, green: 0.376, blue: 0.6, alpha: 1)
        }
    }
    @IBOutlet weak var exclamationLabel: UIButton!
    @IBOutlet weak var approachingLabel: UILabel!

    
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

}
