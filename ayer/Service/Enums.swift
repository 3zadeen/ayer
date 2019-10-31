//
//  Enums.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation

public enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}


public enum Query {
    case forecast
    case weather
}

public enum TemperatureUnit: String {
    case metric = "metric"
    case imperial = "imperial"
}
