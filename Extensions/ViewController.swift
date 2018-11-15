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
    
    // Dismiss the keyboard when you tap on the view
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Present an alert to the user
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // Add corner radius to a button
    func addCornerRadius(to button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
    }
    
}
