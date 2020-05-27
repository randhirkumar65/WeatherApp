//
//  Extensions.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

// MARK: - UITableView related extensions
extension UITableView {
    func reloadDataInMainQueue() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
}

// MARK: - Date related extensions
extension Date {
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getWeekDay() -> String {
        let calendar = Calendar.current
        let component = calendar.component(.weekday, from: self)
        switch component {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "No such days"
        }
    }
}

// MARK: - UIImageView related extensions
extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
