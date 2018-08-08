//
//  DeveloperModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol StoreEntryDeveloper {
    var name: String { get set }
    var email: String { get set }
    var phone: String { get set }
    var experience: Int { get set }
    var country: String { get set }
    var isAvailable: Bool { get set }
}

protocol DeveloperStoreFetcher {
    func fetchAllDevelopers() throws -> [Developer]
}

protocol DeveloperStoreModifier {
    func addDeveloper(_ entry: DeveloperEntry)
    var didUpdateStore: (() -> Void)? { get set }
}

class DeveloperStore: DeveloperStoreFetcher, DeveloperStoreModifier {
    
    //Context used by this store
    var context: NSManagedObjectContext!
    
    init(with context: NSManagedObjectContext) {
        self.context = context
    }
    
    static var defaultStore: DeveloperStore {
        let context: NSManagedObjectContext = ((UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext)
        return DeveloperStore(with: context)
    }
    
    //Get all the developers from database
    func fetchAllDevelopers() throws -> [Developer] {
        let request: NSFetchRequest<Developer> = Developer.fetchRequest()
        do {
            let developers = try context.fetch(request)
            return developers
        } catch {
            throw error
        }
    }
    
    //Add Developer from developer entry
    func addDeveloper(_ entry: DeveloperEntry) {
        _ = Developer.createDeveloper(matching: entry, in: context)
        do {
            try context.save()
            postNotificationForStoreChange()
            if let didUpdateStore = didUpdateStore {
                didUpdateStore()
            }
        } catch {
            print(error)
        }
    }
    
    var didUpdateStore: (() -> Void)?
    
    private func postNotificationForStoreChange() {
        let notification = Notification(name: DeveloperStore.storeModifiedNotification)
        NotificationCenter.default.post(notification)
    }
    
    
    static let storeModifiedNotification = Notification.Name(rawValue: "storeModifiedNotification")
    
    
    
}
