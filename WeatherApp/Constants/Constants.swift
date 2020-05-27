//
//  Constants.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

let kGenericError = "Something went wrong"

// MARK: - API Constants
let API_KEY = "66c3fd0cb6de2383542585703136321a"

// MARK: - Cell Identifiers
let kWeatherCellIdentifiers = "WeatherTableViewCell"
let kWeatherConditionCellIdentifiers = "WeeklyWeatherConditionCell"

// MARK: - UserDefaults keys
let kWeatherDefaultsKey = "weatherData"


// MARK: - StoryBoard Identifiers
let kWeatherDetailsScreen = "WeatherDetailVC"
let kSearchScreen = "SearchViewController"

// MARK: - Screen Size
struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
