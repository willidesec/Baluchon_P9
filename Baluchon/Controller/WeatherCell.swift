//
//  WeatherCell.swift
//  Baluchon
//
//  Created by William on 05/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherInformationLabel: UILabel!
    
    // MARK: - Properties
    var weather: Weather! {
        didSet {
            cityLabel.text = weather.city
            cityLabel.adjustsFontSizeToFitWidth = true
            temperatureLabel.text = "\(weather.temperature)°C"
            weatherInformationLabel.text = weather.text
            weatherInformationLabel.adjustsFontSizeToFitWidth = true
        }
    }
        
    // MARK: - Methods

}
