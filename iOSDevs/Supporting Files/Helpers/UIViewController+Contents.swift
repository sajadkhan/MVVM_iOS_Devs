//
//  UIViewController+Contents.swift
//  iOSDevs
//
//  Created by Sajad on 8/8/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var contents: UIViewController {
        if let navVC = self as? UINavigationController {
            return navVC.visibleViewController ?? navVC
        } else {
            return self
        }
        
    }
}


