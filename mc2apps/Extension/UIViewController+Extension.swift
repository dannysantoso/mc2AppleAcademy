//
//  UIViewController+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension UIViewController{
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //ngambil appdelegate, jadi semua yang ada di appdelegate dapat diakses
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
}


extension UITableViewCell{
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //ngambil appdelegate, jadi semua yang ada di appdelegate dapat diakses
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
}
