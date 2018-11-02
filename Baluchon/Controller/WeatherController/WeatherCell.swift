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
    var weather: WeatherChannel! {
        didSet {
            cityLabel.text = weather.location.city
            cityLabel.adjustsFontSizeToFitWidth = true
            temperatureLabel.text = "\(weather.item.condition.temp)°C"
            weatherInformationLabel.text = weather.item.condition.text
            weatherInformationLabel.adjustsFontSizeToFitWidth = true
        }
    }
        
    // MARK: - Methods

}
