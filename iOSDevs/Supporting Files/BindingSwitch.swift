//
//  BindingControl.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
import UIKit

class BindingSwitch : UISwitch {
    
    var valueChanged :(UISwitch) -> Void = {_ in }
    
    func bind(callback :@escaping (UISwitch) -> Void) {
        self.valueChanged = callback
        self.addTarget(self, action: #selector(controlValueDidChanged(_:)), for: .valueChanged)
    }
    
    @objc func controlValueDidChanged(_ control: UISwitch) {
        self.valueChanged(control)
    }
    
}
