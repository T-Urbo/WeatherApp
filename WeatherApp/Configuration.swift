//
//  Configuration.swift
//  WeatherApp
//
//  Created by Timothey Urbanovich on 13/03/2022.
//

import Foundation

let apiKey: String = "c4d3ef97c595972e94871a5a88eaf4cb"

let baseURL: URL! = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=c4d3ef97c595972e94871a5a88eaf4cb")

let jsonData: Data? = """
{"coord":{"lon":-80,"lat":40.44},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":41.5,"feels_like":36.81,"temp_min":37.4,"temp_max":45,"pressure":1021,"humidity":80},"visibility":16093,"wind":{"speed":3.04,"deg":79},"clouds":{"all":90},"dt":1585068301,"sys":{"type":1,"id":3510,"country":"US","sunrise":1585048554,"sunset":1585092969},"timezone":-14400,"id":5206379,"name":"Pittsburgh","cod":200}
""".data(using: .utf8)

struct Weather: Codable {
    var temp: Double?
    var humidity: Double?
    var country: String?
}

struct WeatherMain: Codable {
    let main: Weather
}

struct City: Codable {
    var name: String?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}

func DecodeJSONData(jsonData: Data, temperature: inout Double, humidity: inout Double, country: inout String) {
    
    do {
        let weatherData = try? JSONDecoder().decode(WeatherMain.self, from: jsonData)
        print(weatherData)
        if let weatherData = weatherData {
            let weather = weatherData.main
            print(weather.humidity!)
            print(weather.temp!)
            
            temperature = weather.temp!
            humidity = weather.humidity!
            country = weather.country!
        }
    }
    
    
}



struct WeatherManager {
    
func decodeJSONData(jsonData: Data) -> Weather?{
        do {
            let weatherData = try? JSONDecoder().decode(WeatherMain.self, from: jsonData)
            print(weatherData)
            if let weatherData = weatherData {
                let weather = weatherData.main
                
                return weatherData.main
                print(weather.humidity!)
                print(weather.temp!)
                
                
                
            }
        }
        return nil
        
    }
}

func PullJSONData(url: URL?, forecast: Bool)
{
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        if let error = error {
            print("arror acquired: \(error.localizedDescription)")
        }
        
        let weatherManager = WeatherManager()
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("HTTP Response Error acquired")
            return
        }
        
        guard let data = data else {
            print("No Response Error acquired ")
            return
        }
        
        if (!forecast)
        {
            weatherManager.decodeJSONData(jsonData: jsonData!)
        } else {
            
        }
    }
    task.resume()
}


