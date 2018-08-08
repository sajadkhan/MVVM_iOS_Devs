//
//  DeveloperModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
import CoreData

class DeveloperStore {
    //Context used by this store
    var context: NSManagedObjectContext!
    
    init(with context: NSManagedObjectContext) {
        self.context = context
    }
    
    //Get all the developers from database
    func allDevelopers() throws -> [Developer] {
        let request: NSFetchRequest<Developer> = Developer.fetchRequest()
        do {
            let developers = try context.fetch(request)
            return developers
        } catch {
            throw error
        }
    }
}
