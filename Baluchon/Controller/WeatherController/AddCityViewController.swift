//
//  AddCityViewController.swift
//  Baluchon
//
//  Created by William on 01/11/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

protocol AddNewCityDelegate {
    func addNewCity(_ name: String)
}

class AddCityViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var newCityDelegate: AddNewCityDelegate!
    
    // MARK: - OUTLET
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTION
    @IBAction func addButtonDidTapped() {
        let cityName = getCityName()
        newCityDelegate.addNewCity(cityName)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - METHODS
    func getCityName() -> String {
        guard let cityName = cityTextField.text else { return "" }
        return cityName
    }
}
