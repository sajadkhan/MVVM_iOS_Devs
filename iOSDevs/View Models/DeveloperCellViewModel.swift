//
//  DeveloperCellViewModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation

class DeveloperCellViewModel {
    var title: String
    var subTitle: String
    
    init(with developer: Developer) {
        title = developer.name!
        subTitle = "\(developer.experience) years"
    }
}
