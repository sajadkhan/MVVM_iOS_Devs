//
//  DeveloperDetailViewViewModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation


protocol DeveloperDetailViewViewModel {
    var name: Dynamic<String> { get }
    var email: Dynamic<String> { get }
    var phone: Dynamic<String> { get }
    var experience: Dynamic<String> { get }
    var country: Dynamic<String> { get }
    var available: Dynamic<String> { get }
}

class DeveloperDetailViewModel: DeveloperDetailViewViewModel {
    var name: Dynamic<String>
    var email: Dynamic<String>
    var phone: Dynamic<String>
    var experience: Dynamic<String>
    var country: Dynamic<String>
    var available: Dynamic<String>
    
    init(with developer: Developer) {
        name = Dynamic(developer.name ?? "")
        email = Dynamic(developer.email ?? "")
        phone = Dynamic(developer.phone ?? "")
        experience = Dynamic("\(developer.experience) years")
        country = Dynamic(developer.country ?? "")
        available = Dynamic(developer.isAvailable ? "Yes" : "No")
        
    }
}
