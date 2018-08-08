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
    
    lazy var viewModel = DeveloperListModelView(with: DeveloperStore.defaultStore)
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        //Bind to cell view models
        viewModel.developerCellViewModels.bindAndFire { [unowned self] developeCellViewModels in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        //Bind selected developer
        viewModel.selectedDeveloper.bind { [unowned self] developer in
            DispatchQueue.main.async {
               self.performSegue(withIdentifier: "showDeveloper", sender: developer)
            }
        }
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDevelopers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath)
        
        let cellViewModel = viewModel.developerCellViewModel(at: indexPath.row)
        cell.textLabel?.text = cellViewModel.title
        cell.detailTextLabel?.text = cellViewModel.subTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectDeveloperCell(at: indexPath.row)
    }
    
}


//Navigation is yet to be implemented using MVVM

extension DeveloperTableViewController {
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeveloper",
            let developerDetailVC = segue.destination as? DeveloperDetailViewController,
            let developer = sender as? Developer {
            developerDetailVC.viewModel = DeveloperDetailViewModel(with: developer)
        }
    }
}
