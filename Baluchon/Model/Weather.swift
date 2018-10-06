//
//  File.swift
//  Baluchon
//
//  Created by William on 05/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation


class Weather {
    
    var city: String
    var temperature: Int
    
    init(city: String, temperature: Int) {
        self.city = city
        self.temperature = temperature
    }
}
