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

    }
    
    // MARK: - Methods
    fileprivate func setUpConvertButton() {
        convertButton.layer.cornerRadius = convertButton.frame.height / 2
    }

    

}
