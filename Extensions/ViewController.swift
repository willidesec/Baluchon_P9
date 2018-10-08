//
//  ViewController.swift
//  Baluchon
//
//  Created by William on 07/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
