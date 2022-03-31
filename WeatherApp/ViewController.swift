//
//  ViewController.swift
//  WeatherApp
//
//  Created by Timothey Urbanovich on 26/02/2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var temperature: Double = 0
    var humidity: Double = 0
    var country: String = ""
    var weatherManager: WeatherManager = WeatherManager()
    
    var weatherData: Weather = Weather()
    
    @IBOutlet weak var regionNameLabel: UILabel!
    
    @IBOutlet weak var degreesValueLabel: UILabel!
    
    @IBOutlet weak var humidityValueLabel: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherData = weatherManager.decodeJSONData(jsonData: jsonData!)!
        
        degreesValueLabel.text = String(weatherData.temp!)
        
        humidityValueLabel.text = String(weatherData.humidity!)
        PullJSONData(url: baseURL, forecast: false)
        print("Hello github")
//        regionNameLabel.text = weatherData.country!
        
        
    }

}
