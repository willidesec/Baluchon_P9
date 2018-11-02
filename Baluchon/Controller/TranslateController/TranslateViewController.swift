//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by William on 01/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    //MARK: - Properties
    let translateService = TranslateService()
    var text = ""

    // MARK: - Outlet
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var textToTranslateTextView: UITextView!
    

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCornerToBlur()
        
        hideNavigationBar()
    }
    
    //MARK: - Action
    @IBAction func translateButtonDidTapped() {
        translateText()
    }
    
    
    // MARK: - Methods
    
    fileprivate func translateText() {
        text = getTextToTranslate()
        translateService.getTraduction(of: text) { (success, translatedText) in
            if success, let translatedText = translatedText {
                self.translatedTextView.text = translatedText
            } else {
                self.presentAlert(message: "Can't translate the text")
            }
        }
    }
    
    fileprivate func getTextToTranslate() -> String {
        guard let text = textToTranslateTextView.text, !text.isEmpty else {
            presentAlert(message: "No text to translate")
            return ""
        }
        return text
    }

    
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setCornerToBlur() {
        bodyView.layer.cornerRadius = 10
        blurEffect.layer.cornerRadius = 10
        blurEffect.clipsToBounds = true
    }
}
