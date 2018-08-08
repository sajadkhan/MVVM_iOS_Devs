//
//  DeveloperEntry.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
import CoreData

struct DeveloperEntry: StoreEntryDeveloper {
    var name: String
    var email: String
    var phone: String
    var experience: String
    var country: String
    var isAvailable: Bool
}

