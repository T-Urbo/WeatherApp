//
//  Configuration.swift
//  WeatherApp
//
//  Created by Timothey Urbanovich on 13/03/2022.
//

import Foundation

let apiKey: String = "c4d3ef97c595972e94871a5a88eaf4cb"

let baseURL: URL! = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=c4d3ef97c595972e94871a5a88eaf4cb")



///-----------OpenWeather API structures-----------

struct WeatherMain: Codable {
    var coord: Coordinates
    var weather: [Weather] = []
    var main: Main
    var name: String = "name"
    var clouds: Clouds //
}

struct Coordinates: Codable {
    var lon: Double = 0.0
    var lat: Double = 0.0
    
}

struct Weather: Codable {
    var id: Int = 0
    var description: String = "description"
    var icon: String = "icon"
}

struct Clouds: Codable {
    var all: Int = 0
}

struct Main: Codable {
    var temp: Double = 0.0
    var feels_like: Double = 0.0
    var temp_min: Double = 0.0
    var temp_max: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
}

///-----------Search longtitude and latitude with city name API structures-----------

var cityName: String = "Gliwice"
var cityAPIRequest: String = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"

struct CityCoordinatesMain: Codable {
    var coord: CityCoordinates
    var weather: [CityWeather] = []
}

struct CityCoordinates: Codable {
    var lon: Double = 0.0
    var lat: Double = 0.0
}

struct CityWeather: Codable {
    var id: Int = 0
    var description: String = ""
    var icon: String = ""
}
