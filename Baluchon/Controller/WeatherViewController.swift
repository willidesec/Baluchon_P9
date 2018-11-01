//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by William on 27/09/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let weatherService = WeatherService()
    var weatherInfo: WeatherInformations?
    var cities = ["New York", "Lyon"]

    // MARK: - OUTLET
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self

        setUpLayout()
        hideNavigationBar()
        displayWeatherInformations()

    }
    
    // MARK: - ACTION
    
    // MARK: - METHODS
    
    fileprivate func displayWeatherInformations() {
        toggleActivityIndicator(shown: true)
        weatherService.getWeather(for: cities) { (success, weather) in
            self.toggleActivityIndicator(shown: false)
            if success {
                self.weatherInfo = weather
                guard let code = self.weatherInfo?.query.results.channel[0].item.condition.code else { return }
                let imageString = CodeConverter.convertWeatherCodeInImage(weatherCode: code)
                self.weatherImageView.image = UIImage(named: imageString)
                
                self.weatherTableView.reloadData()
            } else {
                self.presentAlert(message: "Can't download weather informations")
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        weatherTableView.isHidden = shown
        activityIndicator.isHidden = !shown
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

// MARK: - EXTENSION

// Extension for TableView
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRow = weatherInfo?.query.count else { return 0}
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let channel = weatherInfo?.query.results.channel[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        
        cell.weather = channel
        
        return cell
    }
    
    
}
