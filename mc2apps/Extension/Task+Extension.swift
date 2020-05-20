//
//  Task+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData


extension Task{
    static func fetchQuery(viewContext: NSManagedObjectContext, selectedMilestone: String, predicate: NSPredicate? = nil, selectedProject: String) -> [Task]{
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        let milestonepredicate = NSPredicate(format: "milestoneOf.milestoneName MATCHES %@ && milestoneOf.projectOf.projectName MATCHES %@", selectedMilestone, selectedProject)
        
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [milestonepredicate, addtionalPredicate])
        } else {
            request.predicate = milestonepredicate
        }
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
        
    }
    
    static func save(viewContext: NSManagedObjectContext, taskName: String, selectedMilestone: Milestone, isChecklist: Bool) -> Task? {
        let newTask = Task(context: viewContext)
        newTask.taskName = taskName
        newTask.isChecklist = isChecklist
        newTask.milestoneOf = selectedMilestone
        
        do {
          try viewContext.save()
            return newTask
        } catch {
           return nil
        }
    }
    
    static func update(viewContext: NSManagedObjectContext, taskName: String, task:[Task], indexTask: Int, isChecklist: Bool){
        
        task[indexTask].taskName = taskName
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
