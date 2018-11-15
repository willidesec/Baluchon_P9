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
        addCornerRadius()
    }
    
    // MARK: - ACTION
    @IBAction func addButtonDidTapped() {
        let cityName = getCityName()
        checkIfTableContainsCityName(cityName)
    }
    
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - METHODS
    func getCityName() -> String {
        guard let cityName = cityTextField.text else { return "" }
        return cityName
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

extension AddCityViewController {
    private func addCornerRadius() {
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
}
