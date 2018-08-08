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
    
    lazy var viewModel = DeveloperTableViewViewModel(with: DeveloperStore.defaultStore)
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelViewBindings()
    }
    
    private func setupModelViewBindings() {
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.didSelectDeveloper = { [weak self] developer in
            self?.performSegue(withIdentifier: "showDeveloper", sender: developer)
        }
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath)
        
        let cellViewModel = viewModel.cellModel(at: indexPath)
        cell.textLabel?.text = cellViewModel.title
        cell.detailTextLabel?.text = cellViewModel.subTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCellModelAt(indexPath: indexPath)
    }
    
}

extension DeveloperTableViewController {
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination.contents as? AddDeveloperViewController {
            destinationVC.store = self.viewModel.store
        }
        else if segue.identifier == "showDeveloper",
            let developerDetailVC = segue.destination as? DeveloperDetailViewController,
            let developer = sender as? Developer {
            developerDetailVC.developer = developer
        }
    }
}
