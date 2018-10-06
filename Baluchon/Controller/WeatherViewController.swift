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
    var weatherInformations: [Weather] = []


    // MARK: - Outlet
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherInformations = createArray()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self

        setUpLayout()
        hideNavigationBar()
    }
    
    // MARK: - Methods
    
    func createArray() -> [Weather] {
        var weathers: [Weather] = []
        
        let nyWeather = Weather(city: "New York", temperature: 28)
        let lyonWeather = Weather(city: "Lyon", temperature: 21)
        
        weathers.append(nyWeather)
        weathers.append(lyonWeather)
        
        return weathers
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

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherInformation = weatherInformations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        
        cell.setWeatherInformation(weather: weatherInformation)
        
        return cell
    }
    
    
}
