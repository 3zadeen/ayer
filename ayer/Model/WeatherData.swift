//
//  WeatherData.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation


struct WeatherData : Decodable {
    
    let date    : Int
    let main    : Main
    let weather : WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case date    = "dt"
        case main    = "main"
        case weather = "weather"
    }
}


struct Main : Decodable {
    
    let temperature : Double
    let pressure    : Double
    let humidity    : Double
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


struct WeatherList : Decodable {
    
    let list : WeatherData
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}
