//
//  WeatherCell.swift
//  Baluchon
//
//  Created by William on 05/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    // MARK: - OUTLET
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherInformationLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    
    // MARK: - NIB
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        addCornerRadius()
    }
    
    // MARK: - PROPERTIES
    var weather: WeatherChannel! {
        didSet {
            cityLabel.text = weather.location.city
            cityLabel.adjustsFontSizeToFitWidth = true
            temperatureLabel.text = "\(weather.item.condition.temp)°C"
            weatherInformationLabel.text = weather.item.condition.text
            weatherInformationLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    // MARK: - METHODS
    private func addShadow() {
        redView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        redView.layer.shadowRadius = 4.0
        redView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        redView.layer.shadowOpacity = 0.4
    }
    
    private func addCornerRadius() {
        redView.layer.cornerRadius = 10
    }
    
}
