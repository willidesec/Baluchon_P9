//
//  Currency.swift
//  Baluchon
//
//  Created by William on 06/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

struct InfoRate: Decodable {
    var date: String?
    var base: String?
    var rates : [String : Float]?
}
