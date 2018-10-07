//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by William on 27/09/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var convertButton: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConvertButton()
        
        hideNavigationBar()

    }
    
    // MARK: - Methods
    fileprivate func setUpConvertButton() {
        convertButton.setGradientBackground(colorOne: UIColor.orangeThemeColor, colorTwo: UIColor.yellowThemeColor, cornerRadius: convertButton.frame.height / 2)
        convertButton.layer.cornerRadius = convertButton.frame.height / 2
    }
    
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Action
    @IBAction func convertButtonDidTapped() {
        CurrencyService.shared.getRate { (success, currency) in
            if success, let currency = currency {
                
            } else {
                print("error")
            }
        }
    }
    

    

}
