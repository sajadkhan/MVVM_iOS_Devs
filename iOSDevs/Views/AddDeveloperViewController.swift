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
    @IBOutlet weak var nameTextField: BindingTextField! {
        didSet {
            nameTextField.bind { self.viewModel.name.value = $0 }
        }
    }
    @IBOutlet weak var emailTextField: BindingTextField! {
        didSet {
            emailTextField.bind { self.viewModel.email.value = $0 }
        }
    }
    @IBOutlet weak var phoneTextField: BindingTextField! {
        didSet {
            phoneTextField.bind { self.viewModel.phone.value = $0 }
        }
    }
    @IBOutlet weak var experienceTextField: BindingTextField! {
        didSet {
            experienceTextField.bind { self.viewModel.experience.value = $0 }
        }
    }
    @IBOutlet weak var countryTextField: BindingTextField! {
        didSet {
            countryTextField.bind { self.viewModel.country.value = $0 }
        }
    }
    
    @IBOutlet weak var isAvailableSwitch: BindingSwitch! {
        didSet {
            isAvailableSwitch.bind { self.viewModel.available.value = $0.isOn ? "Yes" : "No" }
        }
    }
    
    
    //View Model
    var viewModel = AddDeveloperViewModel(with: DeveloperStore.defaultStore)
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        viewModel.feedback.bindAndFire { [weak self] feedback in
            if feedback != nil {
                self?.showAlert(with: feedback!)
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        if viewModel.addToStore() {
            dismiss(animated: true)
        }
    }
    
    private func showAlert(with feedback: Feedback) {
        let alert = UIAlertController(title: feedback.title ,
                                      message: feedback.message,
                                      preferredStyle: .alert)
        
        if let fdAction = feedback.action {
            alert.addAction(UIAlertAction(title: fdAction.name,
                                          style: .cancel,
                                          handler: { action in
                fdAction.completion?()
            }
            ))
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
