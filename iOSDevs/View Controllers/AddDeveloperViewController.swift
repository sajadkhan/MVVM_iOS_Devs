//
//  AddDeveloperViewController.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import UIKit

class AddDeveloperViewController: UITableViewController {

    //Mark: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var isAvailableSwitch: UISwitch!
    
    let store: DeveloperStoreModifier? = nil
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - IBActions
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        if validateInput() {
            //Save In store
            if let store = store {
                let entry = createDeveloperEntry()
                store.addDeveloper(entry)
            }
            dismiss(animated: true)
        } else {
            //Show Alert
            let alert = UIAlertController(title: "Invalid Input",
                                          message: "Please fill the required fields.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: .cancel,
                                          handler: nil))
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    //Create a Developer Entry from user input.
    private func createDeveloperEntry() -> DeveloperEntry {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let phone = phoneTextField.text!
        let experience = experienceTextField.text!
        let country = countryTextField.text!
        let isAvailable = isAvailableSwitch.isOn
        
        return DeveloperEntry(name: name,
                              email: email,
                              phone: phone,
                              experience: experience,
                              country: country,
                              isAvailable: isAvailable)
    }
    
    //Validate Input
    private func validateInput() -> Bool {
        return (emailTextField.text?.isEmpty)! || (nameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)!
    }
}
