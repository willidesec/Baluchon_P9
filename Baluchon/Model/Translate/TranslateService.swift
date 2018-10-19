//
//  TranslateService.swift
//  Baluchon
//
//  Created by William on 12/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

class TranslateService {
    
    // MARK: - Properties
    private let translateUrl = "https://translation.googleapis.com/language/translate/v2?"
    private lazy var url = URL(string: translateUrl)!
    private var task: URLSessionDataTask?
    private var translateSession: URLSession
    
    // MARK: - Init
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // MARK: - Methods
    func getTraduction(of text: String, callback: @escaping (Bool, String?) -> Void) {
        let request = createTranslateRequest(with: text)
        
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    print("error1")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("error2")
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translation.self, from: data),
                    let translate = responseJSON.data.translations[0].translatedText else {
                        callback(false, nil)
                        print("error3")
                        return
                }
                callback(true, translate)
            }
        }
        task?.resume()
    }
    
    private func createTranslateRequest(with text: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encodingText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(encodingText)
        let body = "key=AIzaSyD-pTMf5vbKMn4hnl5RUr2gblSW68_sIZs&q=\(encodingText!)&target=en&source=fr"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }

}
