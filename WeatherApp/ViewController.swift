//
//  ViewController.swift
//  WeatherApp
//
//  Created by Timothey Urbanovich on 26/02/2022.
//

// MARK: Add nil error handling => DONE!
// MARK: Add cancel gesture with tapping on screen to searchBar or add the Cancel button => DONE!
// MARK: Format the data to the correct form(Day, Time) => DONE!
// MARK: Add geolocation default weather values =>
// MARK: Format time label in center => DONE!
// MARK: Change search bar call from the search button to regionLabel => DONE!
// MARK: Make the code structurized
// MARK: Change the gradient
// MARK: Close the search bar field after pressing the search button

import UIKit
import Foundation

class ViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var searchBarField: UISearchBar!
    
    @IBOutlet weak var regionNameButton: UIButton!
    
    @IBOutlet weak var searchBarHieghtConstreint: NSLayoutConstraint!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
    @IBOutlet weak var degreesValueLabel: UILabel!
    
    @IBOutlet weak var humidityValueLabel: UILabel!
    
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    @IBOutlet weak var tempMinLabel: UILabel!
    
    var searchBarButtonItem:  UIBarButtonItem?
    
    var url: String = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=c4d3ef97c595972e94871a5a88eaf4cb"
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        regionNameButton.center = self.view.center
        
        
        showCurrentTime()
        parseJSONData(url: url)
        
        
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchBarField.delegate = self
        
        
        print(cityAPIRequest)
        print(cityName)
        
    }
    
    @IBAction func onRegionNameButtonClick(_ sender: Any) {
        print("Test")
        self.searchBarField.searchBarStyle = .minimal
        self.searchBarField.searchTextField.backgroundColor = .white
        searchBarField.tintColor = .white
        self.searchBarField.setShowsCancelButton(true, animated: true)
//        self.searchBarField.showsCancelButton = true
        searchBarHieghtConstreint.constant = 50
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    func parseJSONData(url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Failed to parse JSON data")
                return
            }
            
            var weatherMain: WeatherMain?
            
            do {
                weatherMain = try JSONDecoder().decode(WeatherMain.self, from: data)
            }
            catch {
                print(String(describing: error))
            }
            
            DispatchQueue.main.async {
                if weatherMain != nil {
                    self.regionNameButton.setTitle(weatherMain?.name, for: .normal)
                    self.degreesValueLabel.text = String(Int(self.convertKelvinToCelsius(temp: weatherMain!.main.temp_max))) + "°"
                    self.degreesValueLabel.addCharacterSpacing(kernValue: 20)
                    self.humidityValueLabel.text = String(weatherMain!.main.humidity)
                    self.tempMaxLabel.text = String(Int(self.convertKelvinToCelsius(temp: weatherMain!.main.temp_max))) + "°C"
                    self.tempMinLabel.text = String(Int(self.convertKelvinToCelsius(temp: weatherMain!.main.temp_min))) + "°C"
                    self.weatherConditionLabel.text = "Cloudy"
                }
                else {
                    print("SOMETHING WENT WRONG")
                    let alert = UIAlertController(title: "Alert", message: "Something went wrong, please, check city name for an errors or choose another one!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        })
        task.resume()
        
    }
    
    func convertKelvinToCelsius(temp: Double) -> Double {
        return temp - 273.15
    }
    
    func showCurrentTime() {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE, HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
    
        let currentDate = formatter.string(from: Date())
        print(currentDate)
        self.currentTimeLabel.text = currentDate
        
        var weekDay = Calendar.current.component(.weekday, from: Date())
    }
    
}

extension UILabel {
    static func spaceLabel() -> UILabel {
        let spacingLabel = UILabel()
        spacingLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        spacingLabel.textColor = .white
        spacingLabel.textAlignment = .center
        spacingLabel.text = ""
        return spaceLabel()
    }
    
    
    func addCharacterSpacing(kernValue kernValue: Double) {
        if let labelText = text, labelText.isEmpty == false {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern, value: kernValue, range: _NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
    
    
}

extension ViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard self.searchBarField.text != nil else {
            print("input is nil")
            return
        }
        
        
        cityName = searchBar.text!.lowercased()
        
        print(cityName)
        
        parseJSONData(url: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=c4d3ef97c595972e94871a5a88eaf4cb")
        
        searchBarHieghtConstreint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
//        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        
        searchBarHieghtConstreint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.searchBarField.text else {
            return
        }
        print(text)
    }
}
