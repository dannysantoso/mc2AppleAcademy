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
    
    static func fetchClosestMilestone(viewContext: NSManagedObjectContext) -> [Milestone] {
        
        let request: NSFetchRequest<Milestone> = Milestone.fetchRequest()
        
        let sort = NSSortDescriptor(key: "deadline", ascending: true)
        request.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "isCompleted = \(NSNumber(value: false))")
        request.predicate = predicate
        
        request.fetchLimit = 2
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        
        return result
    }
        
    
    static func update(viewContext: NSManagedObjectContext, milestoneName: String, milestone: [Milestone], indexMilestone: Int, deadline: Date, color: String){
        milestone[indexMilestone].milestoneName = milestoneName
        milestone[indexMilestone].deadline = deadline
        milestone[indexMilestone].color = color
        
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
    static func isCompleted(viewContext: NSManagedObjectContext, isCompleted: Bool, milestone:[Milestone], indexMilestone: Int){
        milestone[indexMilestone].isCompleted = isCompleted
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
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
    
    static func deleteAll(viewContext: NSManagedObjectContext){

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Project")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try? viewContext.execute(deleteRequest)
        
    }
    
    static func deleteData(viewContext: NSManagedObjectContext, milestone: [Milestone], indexMilestone: Int){
        viewContext.delete(milestone[indexMilestone])
        
        do {
            try viewContext.save()
        } catch {
           
        }
    }
}
