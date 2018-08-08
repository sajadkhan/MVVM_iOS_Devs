//
//  Developer.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import UIKit
import CoreData

class Developer: NSManagedObject {
    // Factory method to create new Developer in the database, from the given entry.
    class func createDeveloper(matching entry: StoreEntryDeveloper, in context: NSManagedObjectContext) -> Developer {
        
        let developer = Developer(context: context)
        developer.name = entry.name
        developer.email = entry.email
        developer.phone = entry.phone
        developer.experience = Int32(entry.experience)!
        developer.isAvailable = entry.isAvailable
        developer.country = entry.country
        
        return developer
    }
}
