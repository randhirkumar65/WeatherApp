//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var regionLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
   @IBOutlet weak private var backgroungImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(timeText: String, regionText: String,temperature: String, bgImage: String) {
        timeLabel.text = timeText
        regionLabel.text = regionText
        temperatureLabel.text = "\(temperature) °"
    }
}
