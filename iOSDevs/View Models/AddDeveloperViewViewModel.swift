//
//  AddDeveloperViewViewModel.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation

struct Feedback {
    struct Action {
        let name: String
        let completion: (() -> Void)?
    }
    
    let title: String?
    let message: String?
    let action: Action?
    
}

protocol AddDeveloperViewViewModel {
    var name: Dynamic<String> { get set }
    var email: Dynamic<String> { get set }
    var phone: Dynamic<String> { get set }
    var experience: Dynamic<String> { get set }
    var country: Dynamic<String> { get set }
    var available: Dynamic<String> { get set }
    
    func validateInput() -> Bool
    func addToStore() -> Bool
}

class AddDeveloperViewModel: AddDeveloperViewViewModel {
    
    var store: DeveloperStoreModifier!
    
    init(with store: DeveloperStoreModifier) {
        self.store = store
    }
    
    var name: Dynamic<String> = Dynamic("")
    var email: Dynamic<String> = Dynamic("")
    var phone: Dynamic<String> = Dynamic("")
    var experience: Dynamic<String> = Dynamic("")
    var country: Dynamic<String> = Dynamic("")
    var available: Dynamic<String> = Dynamic("")
    
    func validateInput() -> Bool {
        return !name.value.isEmpty && !email.value.isEmpty && !phone.value.isEmpty && !experience.value.isEmpty
    }
    
    func addToStore() -> Bool {
        if validateInput() {
            //Save In store
            let entry = createDeveloperEntry()
            store.addDeveloper(entry)
            return true
        } else {
            let action = Feedback.Action(name: "Cancel",
                                         completion: { [weak self] in
                self?.feedback = Dynamic(nil)
            })
            self.feedback.value = Feedback(title: "Invalid Input",
                                             message: "Please fill the required fields.",
                                             action: action
            )
            return false
        }
    }
    
    var feedback: Dynamic<Feedback?> = Dynamic(nil)
    
    //Create a Developer Entry from user input.
    private func createDeveloperEntry() -> DeveloperEntry {
        return DeveloperEntry(name: name.value,
                              email: email.value,
                              phone: phone.value,
                              experience: Int(experience.value)!,
                              country: country.value,
                              isAvailable: available.value == "Yes" ? true : false)
    }
    
}




