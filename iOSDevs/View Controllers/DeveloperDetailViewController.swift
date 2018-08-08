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
    
    //MARK: - Model
    var developer: Developer? {
        didSet {
            if developer != nil {
                updateUI(with: developer!)
            }
        }
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let developer = developer {
            updateUI(with: developer)
        }
    }
    
    private func updateUI(with developer: Developer) {
        nameLabel?.text = developer.name
        emailLabel?.text = developer.email
        phoneLabel?.text = developer.phone
        experienceLabel?.text = "\(developer.experience) years"
        countryLabel?.text = developer.country
        availablityLabel?.text = developer.isAvailable ? "Yes" : "No"
    }
    

}
