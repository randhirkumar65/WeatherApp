//
//  WeatherDetailVC.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak private var cityName: UILabel!
    @IBOutlet weak private var weatherCondition: UILabel!
    @IBOutlet weak private var headerImageView: UIImageView!
    @IBOutlet weak private var todayDaysLabel: UILabel!
    @IBOutlet weak private var feelsLikeLabel: UILabel!
    @IBOutlet weak private var tempLabel: UILabel!
    @IBOutlet weak private var weatherCondImgView: UIImageView!
    @IBOutlet weak private var windLabel: UILabel!
    @IBOutlet weak private var sunriseLabel: UILabel!
    @IBOutlet weak private var sunSetLabel: UILabel!

    var dataSource: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherDetails()
    }
    
    private func setWeatherDetails() {
        cityName.text = dataSource?.name
        if let data = dataSource?.weather, data.count > 0 {
            let icon = data[0].icon
            weatherCondition.text = data[0].main
            setBackgroundWeatherImage(id: data[0].id ?? 800)
            if let url = URL(string: "http://openweathermap.org/img/wn/\(icon ?? "02d")@2x.png") {
                weatherCondImgView.loadImage(from: url)
            }
        }
        todayDaysLabel.text = Date().getWeekDay()
        feelsLikeLabel.text = "feels like: \(dataSource?.main?.feelsLike ?? 99)"
        tempLabel.text = "Temperature:\n\(dataSource?.main?.temp ?? 21)°"
        windLabel.text = "Wind:\n\(dataSource?.wind?.speed ?? 21)"
        sunriseLabel.text = "\(dataSource?.sys?.getSunriseTime ?? "5.30 AM")"
        sunSetLabel.text = "\(dataSource?.sys?.getSunSetTime ?? "7.00 PM")"
    }
    
    private func setBackgroundWeatherImage(id: Int) {
        switch id {
        case 200...232:
            // ThunderStorm
            headerImageView.image = UIImage(named: "thunderstorm")
        case 300...321:
            // Drizzle
            headerImageView.image = UIImage(named: "drizzle")
        case 500...531:
            // Rain
            headerImageView.image = UIImage(named: "rainy")
        case 600...622:
            // Snow
            headerImageView.image = UIImage(named: "snow")
        case 701...781:
            // Atmosphere
            headerImageView.image = UIImage(named: "blue_gradient")
        case 800:
            //clear
            headerImageView.image = UIImage(named: "clear")
        case 801...804:
            //clouds
            headerImageView.image = UIImage(named: "clouds")
        default:
            break
        }
    }
}
