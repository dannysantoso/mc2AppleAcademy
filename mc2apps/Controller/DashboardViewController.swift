//
//  DashboardViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 22/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

//    @IBOutlet weak var dashboardLabel: UILabel!
//    @IBOutlet weak var approachingLabel: UILabel!
//    @IBOutlet weak var exclamationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    

}
