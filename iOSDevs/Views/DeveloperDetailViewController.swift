//
//  DeveloperDetailViewController.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import UIKit

class DeveloperDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var availablityLabel: UILabel!
    
    //MARK: - Model View
    
    var viewModel: DeveloperDetailViewModel? {
        didSet {
            if viewModel != nil {
                setupUI()
            }
        }
    }
   
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
    }
    
    private func setupUI() {
        viewModel?.name.bindAndFire { [unowned self] name in
            DispatchQueue.main.async {
                self.nameLabel?.text = name
            }
        }
        
        viewModel?.email.bindAndFire { [unowned self] email in
            DispatchQueue.main.async {
                self.emailLabel?.text = email
            }
        }
        
        viewModel?.phone.bindAndFire { [unowned self] phone in
            DispatchQueue.main.async {
                self.phoneLabel?.text = phone
            }
        }
        
        viewModel?.experience.bindAndFire { [unowned self] experience in
            DispatchQueue.main.async {
                self.experienceLabel?.text = experience
            }
        }
        
        viewModel?.available.bindAndFire { [unowned self] available in
            DispatchQueue.main.async {
                self.availablityLabel?.text = available
            }
        }
        
        viewModel?.country.bindAndFire { [unowned self] country in
            DispatchQueue.main.async {
                self.countryLabel?.text = country
            }
        }
    }
    

}
