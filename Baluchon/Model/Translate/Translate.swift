//
//  Translate.swift
//  Baluchon
//
//  Created by William on 12/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation


struct Translation: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String?
}
