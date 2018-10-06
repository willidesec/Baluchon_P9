//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by William on 01/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCornerToBlur()
        
        hideNavigationBar()
    }
    
    // MARK: - Methods
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setCornerToBlur() {
        bodyView.layer.cornerRadius = 10
        blurEffect.layer.cornerRadius = 10
        blurEffect.clipsToBounds = true
    }
}
