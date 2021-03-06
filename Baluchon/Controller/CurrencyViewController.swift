//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by William on 27/09/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    //MARK: - PROPERTIES
    let currencyService = CurrencyService()
    
    // MARK: - Outlet
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var eurTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        hideNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addCornerRadius(to: convertButton)
    }
    
    // MARK: - ACTION
    @IBAction func convertButtonDidTapped() {
        convertCurrency()
    }
    
    //MARK: - METHODS
    fileprivate func convertCurrency() {
        toggleActivityIndicator(shown: true)
        
        // Recover the amount to convert in the textField
        let baseAmount = getAmount(textfield: eurTextField)
        
        currencyService.getRate { (success, usdRate) in
            self.toggleActivityIndicator(shown: false)
            
            if success, let usdRate = usdRate {
                let convertedAmount = baseAmount * usdRate
                // Convert the amount in string with two decimal numbers
                let stringAmount = String(format: "%.2f", convertedAmount)
                self.usdTextField.text = stringAmount
            } else {
                // Display an error
                self.presentAlert(message: "Can't convert the currency")
            }
        }
    }
    
    func getAmount(textfield: UITextField) -> Float {
        guard let stringAmount = textfield.text else { return 0.0 }
        guard let amount = Float(stringAmount) else { return 0.0 }
        return amount
    }
    
    // Enable the convert button only if textfield is not empty
    func setupAddTargetIsNotEmptyTextFields() {
        disableButton(button: convertButton)
        eurTextField.addTarget(self, action: #selector(textFieldIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard let amount = eurTextField.text, !amount.isEmpty else {
            disableButton(button: convertButton)
            usdTextField.text = ""
            return
        }
       activateButton(button: convertButton)
    }
    
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        convertButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    fileprivate func activateButton(button: UIButton) {
        button.isEnabled = true
        button.backgroundColor = UIColor.redThemeColor
    }
    
    fileprivate func disableButton(button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = UIColor.darkGray
        button.setTitleColor(UIColor.gray, for: .disabled)
    }

    

}
