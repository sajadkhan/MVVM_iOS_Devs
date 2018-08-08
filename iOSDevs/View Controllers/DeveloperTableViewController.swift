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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeIsChanged),
                                               name: DeveloperStore.storeModifiedNotification,
                                               object: nil)
        
        return DeveloperStore(with: context)
    }()
    
    var developers: [Developer]? {
        didSet {
            if oldValue != developers {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
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
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let developer = developers![indexPath.row]
        performSegue(withIdentifier: "showDeveloper", sender: developer)
    }
    
    // MARK: - Store Changes
    @objc func storeIsChanged() {
        refreshFromStore()
    }
    
    //refresh from store
    func refreshFromStore() {
        developers = try? store.fetchAllDevelopers()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination.contents as? AddDeveloperViewController {
            destinationVC.store = self.store as? DeveloperStoreModifier
        }
        else if segue.identifier == "showDeveloper",
            let developerDetailVC = segue.destination as? DeveloperDetailViewController,
            let developer = sender as? Developer {
            developerDetailVC.developer = developer
        }
    }
    
}
