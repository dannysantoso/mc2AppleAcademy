//
//  UITableViewController+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 20/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension UITableViewCell{
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //ngambil appdelegate, jadi semua yang ada di appdelegate dapat diakses
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
}
