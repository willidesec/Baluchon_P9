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
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var eurTextField: UITextField!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConvertButton()
        
        hideNavigationBar()

    }
    
    // MARK: - Action
    @IBAction func convertButtonDidTapped() {
        
        let eurAmount = getAmount()
        
        CurrencyService.shared.getRate { (success, infoRate) in
            if success, let infoRate = infoRate {
                let exchangeRate = self.getExchangeRate(infoRate: infoRate)
                self.convertCurrency(eur: eurAmount, with: exchangeRate)                
            } else {
                // Afficher un message d'erreur
                print("error")
            }
        }
    }
    
    // MARK: - Methods
    func getAmount() -> Float {
        guard let stringAmount = eurTextField.text else { return 0 }
        print(stringAmount)
        let amount = (stringAmount as NSString).floatValue
        print(amount)
        return amount
    }
    
    func getExchangeRate(infoRate: InfoRate) -> Float {
        guard let usdRate = infoRate.rates?["USD"] else { return 0 }
        return usdRate
    }
    
    func convertCurrency(eur: Float, with exchangeRate: Float) {
        let usdAmount = eur * exchangeRate
        updateDisplay(usd: usdAmount)
    }
    
    func updateDisplay(usd: Float) {
        let stringUsd = String(describing: usd)
        usdTextField.text = stringUsd
    }
    
    fileprivate func setUpConvertButton() {
        convertButton.setGradientBackground(colorOne: UIColor.orangeThemeColor, colorTwo: UIColor.yellowThemeColor, cornerRadius: convertButton.frame.height / 2)
        convertButton.layer.cornerRadius = convertButton.frame.height / 2
    }
    
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    

}
