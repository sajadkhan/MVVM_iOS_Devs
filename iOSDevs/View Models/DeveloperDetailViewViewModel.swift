//
//  DeveloperDetailViewViewModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation



class DeveloperDetailViewViewModel {
    
    var developer: Developer!
    
    init(_ developer: Developer) {
        self.developer = developer
    }
    
    //Bindings
    
    let name: Dynamic<String>
}
