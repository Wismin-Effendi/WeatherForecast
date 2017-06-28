//
//  Utility.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/28/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import Foundation

struct Util {
    
    static func dateTimeStringFromUnixTimeStamp(_ timestamp: Double) -> String {
        return getDateStringFromUnixTime(timestamp, dateStyle: .short, timeStyle: .short)
    }
    
    
    static func getDateStringFromUnixTime(_ timestamp: Double,dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
    }
    
    static func getUrlEncodedStringOf(_ inputString: String) -> String {
        let myString = inputString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let encodedString = myString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        return encodedString!
    }
}


