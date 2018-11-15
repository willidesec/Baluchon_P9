//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by William on 01/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    //MARK: - PROPERTIES
    let translateService = TranslateService()
    var text = ""

    // MARK: - Outlet
    @IBOutlet weak var textToTranslateTextView: UITextView!
    
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    
    
    

    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        addCornerRadius(to: translateButton)
    }
    
    //MARK: - ACTION
    @IBAction func translateButtonDidTapped() {
        translateText()
    }
    
    
    // MARK: - METHODS
    
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
    
}

extension TranslateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Tap here to enter text" {
            textView.text = ""
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Tap here to enter text"
        }
        textView.resignFirstResponder()
    }
}

