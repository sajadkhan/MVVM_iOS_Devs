//
//  DeveloperTableViewController.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import UIKit
import CoreData

class DeveloperTableViewController: UITableViewController {
    //Model
    lazy var store: DeveloperStoreFetcher = {
        let context: NSManagedObjectContext = ((UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext)
        return DeveloperStore(with: context)
    }()
    
    var developers: [Developer]?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        developers = try? store.fetchAllDevelopers()
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath)
        if let developer = developers?[indexPath.row] {
            cell.textLabel?.text = developer.name
            cell.detailTextLabel?.text = "\(developer.experience) years"
        }
        return cell
    }
    
}
