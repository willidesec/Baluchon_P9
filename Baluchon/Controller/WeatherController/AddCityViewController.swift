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
    var cities: [String]!
    
    // MARK: - OUTLET
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        addCornerRadius(to: addButton)
    }
    
    // MARK: - ACTION
    @IBAction func addButtonDidTapped() {
        let cityName = getCityName()
        checkIfTableContainsCityName(cityName)
        cityTextField.resignFirstResponder()
    }
    
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - METHODS
    func getCityName() -> String {
        if cityTextField.text == "" {
            presentAlert(message: "You have to enter a city name !")
            return ""
        } else {
            guard let cityName = cityTextField.text else { return "" }
            return cityName
        }
    }
    
    func checkIfTableContainsCityName(_ cityName: String) {
        let capitalizedName = cityName.capitalized
        if !cities.contains(capitalizedName) {
            newCityDelegate.addNewCity(capitalizedName)
            dismiss(animated: true, completion: nil)
        } else {
            presentAlert(message: "You already have added \(capitalizedName)")
        }
    }
}

// MARK: - EXTENSION

extension AddCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let cityName = getCityName()
        checkIfTableContainsCityName(cityName)
        return true
    }
}
