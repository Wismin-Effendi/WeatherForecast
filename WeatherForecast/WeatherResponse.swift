//
//  WeatherResponse.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/30/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherResponse: Mappable {
    var city: City?
    var fiveDayForecast: [Forecast2]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        city <- map["city"]
        fiveDayForecast <- map["list"]
    }
}


class City: Mappable {
    var name: String?
    var lat: Float?
    var lon: Float?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        lat <- map["coord.lat"]
        lon <- map["coord.lon"]
    }
}


class Forecast2: Mappable, CustomStringConvertible {
    var timestamp: Int? 
    var temperatureInKelvin: Float?
    var humidity: Int?
    var weatherDescription: String?
    var windSpeed: Float?
    var windDegree: Float?
    
    var numberFormatter = NumberFormatter()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        timestamp <- map["dt"]
        temperatureInKelvin <- map["main.temp"]
        humidity <- map["main.humidity"]
        weatherDescription <- map["weather.0.description"]
        windSpeed <- map["wind.speed"]
        windDegree <- map["wind.deg"]
    }
    
    // convenience method 
    func temperatureInFahrenheit() -> String {
        // set precision for display double number
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.minimumIntegerDigits = 1
        
        let f = 9.0/5.0 * (self.temperatureInKelvin! - 273) + 32.0
        return  numberFormatter.string(from: f as NSNumber)!
    }
    
    var dateTime: String {
        let dateTimeValue = Util.dateTimeStringFromUnixTimeStamp(Double(timestamp!))
        return dateTimeValue
    }
    
    var description: String {
        return "\(temperatureInFahrenheit()) ℉ \(weatherDescription!) Humidity: \(humidity!) Wind: \(windSpeed!) m/s"
    }
}
