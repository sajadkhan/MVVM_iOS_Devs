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

class DeveloperTableViewViewModel {
    
    var store: DeveloperStore!
    
    init(with store: DeveloperStore) {
        let updateDevelopers = { self.developers = try? store.fetchAllDevelopers() }
        store.didUpdateStore = {
            updateDevelopers()
        }
        updateDevelopers()
    }
    
    var developers: [Developer]? {
        didSet {
            if oldValue != developers {
                developerCellViewModels = developers?.map { DeveloperCellViewModel(with: $0) }
            }
        }
    }
    
    var developerCellViewModels: [DeveloperCellViewModel]? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    //Bindings
    var reloadTableViewClosure: (() -> Void)?
    var didSelectDeveloper: ((Developer) -> Void)?
    
    
    //TableView Sources
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return developerCellViewModels?.count ?? 0
    }
    
    func cellModel(at indexPath: IndexPath) -> DeveloperCellViewModel {
        return developerCellViewModels![indexPath.row]
    }
    
    func selectCellModelAt(indexPath: IndexPath) {
        let developer = developers![indexPath.row]
        didSelectDeveloper?(developer)
    }
}
