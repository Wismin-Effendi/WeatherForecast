//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/28/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import Foundation

struct Forecast: CustomStringConvertible {
    
    var dateTime: String
    var temperatureInKelvin: Double
    var weatherDescription: String
    
    var numberFormatter = NumberFormatter()
    
    init(dateTime: String, temperatureInKelvin: Double, description: String) {
        self.dateTime = dateTime
        self.temperatureInKelvin = temperatureInKelvin
        self.weatherDescription = description
        
        // set precision for display double number
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.minimumIntegerDigits = 1
    }
    
    func temperatureInFahrenheit() -> String {
            let f = 9.0/5.0 * (self.temperatureInKelvin - 273) + 32.0
            return  numberFormatter.string(from: f as NSNumber)!
    }
    
    var description: String {
        return "\(dateTime), \(temperatureInFahrenheit()) \(weatherDescription)"
    }
    
    var tempAndDescription: String {
        return "\(temperatureInFahrenheit()) ℉  \(weatherDescription)"
    }
}
