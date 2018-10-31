//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by William on 27/09/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    let weatherService = WeatherService()
    var weathers: [Weather] = []

    // MARK: - Outlet
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var weatherTableView: UITableView!

    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self

        setUpLayout()
        hideNavigationBar()
        displayWeatherInformations()

    }
    
    // MARK: - Action
    
    // MARK: - Methods
    
    fileprivate func displayWeatherInformations() {
        weatherService.getWeather { (success, weather) in
            if success, let weather = weather {
                self.weathers = weather
                self.changeWeatherImageView(weather)
                
                self.weatherTableView.reloadData()
            } else {
                self.presentAlert(message: "Can't download weather informations")
            }
        }
    }
    
    fileprivate func changeWeatherImageView(_ weather: [Weather]) {
        switch weather[0].code {
        case .cloud:
            self.weatherImageView.image = UIImage(named: "Cloud")
        case .cloudy:
            self.weatherImageView.image = UIImage(named: "Cloudy")
        case .rain:
            self.weatherImageView.image = UIImage(named: "Rain")
        case .snow:
            self.weatherImageView.image = UIImage(named: "Snow")
        case .storm:
            self.weatherImageView.image = UIImage(named: "Storm")
        case .sunny:
            self.weatherImageView.image = UIImage(named: "Sun")
        case .wind:
            self.weatherImageView.image = UIImage(named: "Wind")
        }
    }
    
    fileprivate func hideNavigationBar() {
        // Hide the background of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    // Change the layout of the View Weather
    fileprivate func setUpLayout() {
        // Rounded View
        circleView.layer.cornerRadius = circleView.frame.width / 2
        
        // Circle Shadow
        circleView.layer.shadowOffset = CGSize(width: 2, height: 2)
        circleView.layer.shadowRadius = 2
        circleView.layer.shadowOpacity = 0.3
                
    }
}

// MARK: - Extension

// Extension for TableView
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = weathers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        
        cell.weather = weather
        
        return cell
    }
    
    
}
