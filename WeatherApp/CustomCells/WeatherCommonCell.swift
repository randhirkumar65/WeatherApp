//
//  WeatherCommonCell.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 22/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

class WeatherCommonCell: UITableViewCell {

    @IBOutlet weak var leftTopHeaderLabel: UILabel!
    @IBOutlet weak var leftDescLabel: UILabel!
    @IBOutlet weak var rightTopHeaderLabel: UILabel!
    @IBOutlet weak var rightDescLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(leftHeaderText: String,leftDescText: String,rightHeaderText: String,rightDescText: String) {
        leftTopHeaderLabel.text = leftHeaderText
        leftDescLabel.text = leftDescText
        rightTopHeaderLabel.text = rightHeaderText
        rightDescLabel.text = rightDescText
    }
}
