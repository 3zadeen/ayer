//
//  WeatherData.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation
import SwiftUI

struct WeatherData : Decodable {
    
    let date    : Date
    let main    : Main
    let weather : [WeatherCondition]
    let name    : String
    
    enum CodingKeys: String, CodingKey {
        case date    = "dt"
        case main    = "main"
        case weather = "weather"
        case name    = "name"
    }
    
    init?() {
        return nil
    }
}


struct Main : Decodable {
    
    let temperature : Double
    let pressure    : Int
    let humidity    : Int
    let minimumTemp : Double
    let maximumTemp : Double
    
    enum CodingKeys: String, CodingKey {
        case temperature   = "temp"
        case pressure      = "pressure"
        case humidity      = "humidity"
        case minimumTemp   = "temp_min"
        case maximumTemp   = "temp_max"
    }
}

struct WeatherCondition : Decodable {
    
    let main        : String
    let description : String
    let icon        : String
    
    enum CodingKeys: String, CodingKey {
        case main        = "main"
        case description = "description"
        case icon        = "icon"
    }
}

struct City : Decodable {
    
    let name     : String
    let country  : String
    
    enum CodingKeys: String, CodingKey {
        case name    = "name"
        case country = "country"
    }
}


struct WeeklyWeatherList : Decodable {
    
    let list : [WeatherData]
    let city : City
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
        case city = "city"
    }
    
    struct WeatherData : Decodable {
        
        let date    : Date
        let main    : Main
        let weather : [WeatherCondition]
        
        enum CodingKeys: String, CodingKey {
            case date    = "dt"
            case main    = "main"
            case weather = "weather"
        }
        
        init?() {
            return nil
        }
    }
    
    init?() {
        return nil
    }
}
