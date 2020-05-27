//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let base: String?
    let clouds: WeatherCloud?
    let cod: Int?
    let coord: WeatherCoordinate?
    let dt: Int?
    let id: Int?
    let main: WeatherMain?
    let name: String?
    let sys: WeatherSy?
    let timezone: Int?
    let visibility: Int?
    let weather: [Weather]?
    let wind: WeatherWind?
}

struct WeatherWind: Codable {
    let deg: Int?
    let speed: Float?
}

struct Weather: Codable {
    let descriptionField: String?
    let icon: String?
    let id: Int?
    let main: String?
}

struct WeatherSy: Codable {
    let country: String?
    let id: Int?
    let sunrise: Int?
    let sunset: Int?
    let type: Int?
    
    var getSunriseTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone.current
        let date = Date(timeIntervalSince1970: Double(sunrise ?? 1470309336))
        return formatter.string(from: date)
    }
    
    var getSunSetTime: String {
           let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm:ss"
           formatter.timeZone = TimeZone.current
           let date = Date(timeIntervalSince1970: Double(sunset ?? 1590152488))
           return formatter.string(from: date)
       }
}

struct WeatherMain: Codable {
    let feelsLike: Float?
    let humidity: Int?
    let pressure: Int?
    let temp: Float?
    let tempMax: Float?
    let tempMin: Float?
    
    var temperatureInCelsius: String {
        guard let temp = temp else { return ""}
        let temperatureInCelsius = temp - 273.15
        return String(format: "%.0f", temperatureInCelsius)
    }
    var temperatureInFahren: String {
        guard let temp = temp else { return ""}
        let temperatureInCelsius = temp - 273.15
        let fahren = (temperatureInCelsius * 1.8) + 32
        return String(format: "%.0f", fahren)
    }
}

struct WeatherCoordinate: Codable {
    let lat: Float?
    let lon: Float?
}

struct WeatherCloud: Codable {
    let all: Int?
}
