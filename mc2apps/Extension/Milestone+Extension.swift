//
//  Milestone+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData


extension Milestone{
    static func fetchQuery(viewContext: NSManagedObjectContext, selectedProject: String, predicate: NSPredicate? = nil) -> [Milestone]{
        let request: NSFetchRequest<Milestone> = Milestone.fetchRequest()
        
        let projectpredicate = NSPredicate(format: "projectOf.projectName MATCHES %@", selectedProject)
        
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [projectpredicate, addtionalPredicate])
        } else {
            request.predicate = projectpredicate
        }
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
        
    }
    
    static func save(viewContext: NSManagedObjectContext, milestoneName: String, selectedProject: Project, deadline: Date, color: String, isCompleted: Bool) -> Milestone? {
        let newMilestone = Milestone(context: viewContext)
        newMilestone.milestoneName = milestoneName
        newMilestone.deadline = deadline
        newMilestone.isCompleted = isCompleted
        newMilestone.color = color
        newMilestone.projectOf = selectedProject
        
        do {
          try viewContext.save()
            return newMilestone
        } catch {
           return nil
        }
    }
}
