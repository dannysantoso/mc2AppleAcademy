//
//  File.swift
//  mc2apps
//
//  Created by danny santoso on 27/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import UserNotifications
import CoreData
import UIKit

class Notifications:NSObject, UNUserNotificationCenterDelegate{
    
    static func setNotification(project: Project){
        print("\(project.objectID.uriRepresentation())")
        let center = UNUserNotificationCenter.current()
        let badge = UserDefaults.standard.integer(forKey: "badge") + 1
        
        let content = UNMutableNotificationContent()
        content.title = "\(project.projectName!) Project has 1 day left"
        content.badge = NSNumber(value: badge)
        content.body = "Your \(project.projectName!) Project will end on \(formatDate(input: project.deadline!))"
        content.sound = .default
        content.userInfo["projectName"] = project.projectName
        content.userInfo["deadline"] = formatDate(input: project.deadline!)
        content.userInfo["client"] = project.clientName
        UserDefaults.standard.set(badge, forKey: "badge")

        let date = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!
        print(formatDate(input: date))

        
        let timeInterval = project.deadline!.timeIntervalSince(date)
        if timeInterval >= 0 {
            print(timeInterval)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: "\(project.objectID.uriRepresentation())", content: content, trigger: trigger)
            center.add(request) { (error) in
                if error != nil {
                    print("Error = \(error?.localizedDescription ?? "error local notification")")
                }
            }
        }else{
            print("already pass")
        }
    }

    static func removeNotification(_ project: Project) {
        print("\(project.objectID.uriRepresentation())")
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(project.objectID.uriRepresentation())"])
    }

    static func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy hh:mm"
        return formater.string(from: input)
    }

    static func removeBadge() {
        print("remove badge")
        let currentNotif =  UIApplication.shared.applicationIconBadgeNumber
        let badgeCounter = UserDefaults.standard.integer(forKey: "badge") - currentNotif
        UserDefaults.standard.set(
            badgeCounter < 0
                ? 0
                : badgeCounter,
            forKey: "badge")
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

