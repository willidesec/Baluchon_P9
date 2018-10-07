//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by William on 27/09/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    //MARK: - Properties
    let converter = CurrencyConverter()
    
    // MARK: - Outlet
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var eurTextField: UITextField!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConvertButton()
        
        setupAddTargetIsNotEmptyTextFields()
        
        hideNavigationBar()

    }
    
    // MARK: - Action
    @IBAction func convertButtonDidTapped() {
        
        let baseAmount = converter.getAmount(textfield: eurTextField)
        
        CurrencyService.shared.getRate { (success, infoRate) in
            if success, let infoRate = infoRate {
                let exchangeRate = self.converter.getExchangeRate(infoRate: infoRate)
                let convertAmount = self.converter.convertCurrency(eur: baseAmount, with: exchangeRate)
                self.updateDisplay(convertAmount)
            } else {
                // Afficher un message d'erreur
                print("error")
            }
        }
    }
    
    //MARK: - Methods
    func updateDisplay(_ convertedAmount: Float) {
        let stringAmount = String(describing: convertedAmount)
        usdTextField.text = stringAmount
    }
    
    // Enable the convert button only if textfield is not empty
    func setupAddTargetIsNotEmptyTextFields() {
        convertButton.isEnabled = false
        eurTextField.addTarget(self, action: #selector(textFieldIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard let amount = eurTextField.text, !amount.isEmpty else {
            self.convertButton.isEnabled = false
            return
        }
        convertButton.isEnabled = true
    }
    
    fileprivate func setUpConvertButton() {
        convertButton.setGradientBackground(colorOne: UIColor.blueThemeColor, colorTwo: UIColor.lightBlueThemeColor, cornerRadius: convertButton.frame.height / 2)
        convertButton.layer.cornerRadius = convertButton.frame.height / 2
    }
    
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    

}
