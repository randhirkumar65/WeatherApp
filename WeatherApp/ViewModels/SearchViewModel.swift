//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import Foundation

enum WeatherResultType {
    case success
    case failure(errorMsg: String)
}

class SearchViewModel {
    
    var weatherDataArray = [WeatherModel]()
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func loadWeatherData(cityName: String, completion: @escaping (_ resultType: WeatherResultType) -> Void) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_KEY)") else { return }
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(.failure(errorMsg: error?.localizedDescription ?? kGenericError))
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                self.weatherDataArray.append(weatherData)
                self.saveWeatherDataToDefaults(data: self.weatherDataArray)
                completion(.success)
            } catch {
                completion(.failure(errorMsg: error.localizedDescription))
            }
        })
        task.resume()
    }
    
    func getNoOfRows() -> Int {
        return weatherDataArray.count
    }
    
    func getWeatherData(atIndex: Int) -> WeatherModel? {
        guard atIndex < weatherDataArray.count else { return nil }
        return weatherDataArray[atIndex]
    }
    
    func deleteWeatherData(atIndex: Int, completion: (() -> Void)) {
        guard atIndex < weatherDataArray.count else { return }
        weatherDataArray.remove(at: atIndex)
        completion()
    }
    
    func getCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+5:30")
        formatter.dateFormat = "HH:MM a"
        return formatter.string(from: date)
    }
    
    func saveWeatherDataToDefaults(data: [WeatherModel]) {
        let jsonEncoder = JSONEncoder()
        do {
            let encodedData = try jsonEncoder.encode(data)
            userDefaults.set(encodedData, forKey: kWeatherDefaultsKey)
        } catch  {
            print("Unable to write weather Data to defaults")
        }
    }
    
    func loadWeatherDataFromDefaults(completion: (() -> Void)) {
        do {
            guard let weatherData = userDefaults.data(forKey: kWeatherDefaultsKey) else { return }
            let decodeData = try JSONDecoder().decode([WeatherModel].self, from: weatherData)
            weatherDataArray = decodeData
            completion()
        } catch  {
            print("")
        }
    }
}
