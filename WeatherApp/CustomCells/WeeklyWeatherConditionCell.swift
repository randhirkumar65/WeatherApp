//
//  WeeklyWeatherConditionCell.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 22/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

class WeeklyWeatherConditionCell: UITableViewCell {

    @IBOutlet weak  var weatherCondImageView: UIImageView!
    @IBOutlet weak private var maxTempLabel: UILabel!
    @IBOutlet weak private var minTempLabel: UILabel!
    @IBOutlet weak private var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = ""
        minTempLabel.text = ""
        maxTempLabel.text = ""
        weatherCondImageView.image = nil
    }
    
    func configCell(day: String, minTemp: String, maxTemp: String) {
        dayLabel.text = day
        minTempLabel.text = minTemp
        maxTempLabel.text = maxTemp
    }
}
