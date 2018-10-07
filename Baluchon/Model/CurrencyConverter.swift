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
        print(stringAmount)
        let amount = (stringAmount as NSString).floatValue
        print(amount)
        return amount
    }
    
}
