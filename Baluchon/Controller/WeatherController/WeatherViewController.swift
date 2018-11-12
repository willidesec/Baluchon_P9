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

        hideNavigationBar()
        displayWeatherInformations()

    }
    
    // MARK: - ACTION
    @IBAction func addButtonDidTapped(_ sender: Any) {
        let addCityVC = storyboard?.instantiateViewController(withIdentifier: "AddCityScreen") as! AddCityViewController
        addCityVC.cities = cities
        addCityVC.newCityDelegate = self
        present(addCityVC, animated: true, completion: nil)
    }
    
    
    // MARK: - METHODS
    
    fileprivate func displayWeatherInformations() {
        toggleActivityIndicator(shown: true)
        weatherService.getWeather(for: cities) { (success, weather) in
            self.toggleActivityIndicator(shown: false)
            if success {
                self.weatherInfo = weather
                guard let imageCode = self.weatherInfo?.query.results.channel[0].item.condition.code else { return }
                self.changeWeatherImage(imageCode)
                self.weatherTableView.reloadData()
            } else {
                self.presentAlert(message: "Can't download weather informations")
            }
        }
    }
    
    fileprivate func changeWeatherImage(_ code: String) {
        let imageString = CodeConverter.convertWeatherCodeInImage(weatherCode: code)
        self.weatherImageView.image = UIImage(named: imageString)
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
        circleView.layer.cornerRadius = circleView.frame.height / 2
        // Circle Shadow
        circleView.layer.shadowOffset = CGSize(width: 2, height: 2)
        circleView.layer.shadowRadius = 2
        circleView.layer.shadowOpacity = 0.3
                
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayout()
    }
}

// MARK: - EXTENSION

// Extension for TableView
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    // Display the number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRow = weatherInfo?.query.count else { return 0 }
        return numberOfRow
    }
    
    // Display the data in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let channel = weatherInfo?.query.results.channel[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        
        cell.weather = channel
        
        return cell
    }
    
    // Change the weatherImage when taping on the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imageCode = weatherInfo?.query.results.channel[indexPath.row].item.condition.code else { return }
        changeWeatherImage(imageCode)
        
    }
    
    // Delete a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
//            weatherInfo?.query.results.channel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// Extension for protocol Add New City
extension WeatherViewController: AddNewCityDelegate {
    func addNewCity(_ name: String) {
            cities.append(name)
            displayWeatherInformations()
    }
    
    
}
