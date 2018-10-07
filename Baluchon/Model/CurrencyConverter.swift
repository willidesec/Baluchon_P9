//
//  CurrencyConverter.swift
//  Baluchon
//
//  Created by William on 07/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation
import UIKit

class CurrencyConverter {
    
    func getAmount(textfield: UITextField) -> Float {
        guard let stringAmount = textfield.text else { return 0 }
        let amount = (stringAmount as NSString).floatValue
        return amount
    }
    
    func getExchangeRate(infoRate: InfoRate) -> Float {
        guard let usdRate = infoRate.rates?["USD"] else { return 0 }
        return usdRate
    }
    
    func convertCurrency(eur: Float, with exchangeRate: Float) -> Float {
        let usdAmount = eur * exchangeRate
        return usdAmount
    }
    
}
