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
    
    // MARK: - Methods
    func setWeatherInformation(weather: Weather) {
        cityLabel.text = weather.city
        temperatureLabel.text = "\(weather.temperature)°C"
    }

}
