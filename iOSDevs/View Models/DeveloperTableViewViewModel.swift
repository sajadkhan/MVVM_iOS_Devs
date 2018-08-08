//
//  DeveloperTableViewViewModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol DeveloperTableViewViewModel {
    
    func numberOfDevelopers() -> Int
    func developerCellViewModel(at index: Int) -> DeveloperCellViewModel
    func selectDeveloperCell(at index: Int)
    
    var developerCellViewModels: Dynamic<[DeveloperCellViewModel]> { get }
    var selectedDeveloper: Dynamic<Developer?> { get }
}

class DeveloperListModelView: DeveloperTableViewViewModel {
    
    let developerCellViewModels: Dynamic<[DeveloperCellViewModel]> = Dynamic([DeveloperCellViewModel]())
    
    func numberOfDevelopers() -> Int {
        return developerCellViewModels.value.count
    }
    
    func developerCellViewModel(at index: Int) -> DeveloperCellViewModel {
        return developerCellViewModels.value[index]
    }
    
    func selectDeveloperCell(at index: Int) {
        let developer = developers![index]
        selectedDeveloper.value = developer
    }
    
    let selectedDeveloper: Dynamic<Developer?> = Dynamic(nil)
    
    var store: DeveloperStoreFetcher!
    
    init(with store: DeveloperStore) {
        
        let updateDevelopers = {
            self.developers = try? store.fetchAllDevelopers()
            if let developers = self.developers {
                let developerViewModels = developers.map { DeveloperCellViewModel(with: $0) }
                self.developerCellViewModels.value = developerViewModels
            }
        }
        
        store.didUpdateStore = {
            updateDevelopers()
        }
        updateDevelopers()
    }
    
    
    var developers: [Developer]? {
        didSet {
            if oldValue != developers {
            }
        }
    }
    

}
