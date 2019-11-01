//
//  DailyWeatherViewModel.swift
//  ayer
//
//  Created by Ezaden Seraj on 31/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation
import SwiftUI

struct DailyWeatherViewModel: Identifiable {
    private let weatherData: WeeklyWeatherList.WeatherData
    
    var id: String {
      return temperature + maxTemperature + minTemperature
    }
    
    var temperature: String {
        return String(format: "%.1f°", weatherData.main.temperature)
    }
    
    var maxTemperature: String {
      return String(format: "%.1f", weatherData.main.maximumTemp)
    }
    
    var minTemperature: String {
      return String(format: "%.1f", weatherData.main.minimumTemp)
    }
    
    var day: String {
      return dayFormatter.string(from: weatherData.date)
    }
    
    var date: String {
      return dateFormatter.string(from: weatherData.date)
    }
    
    var icon: String {
        return weatherData.weather.first?.icon ?? ""
    }
    
    init(weatherData: WeeklyWeatherList.WeatherData) {
      self.weatherData = weatherData
    }
}

extension DailyWeatherViewModel: Hashable {
  static func == (lhs: DailyWeatherViewModel, rhs: DailyWeatherViewModel) -> Bool {
    return lhs.day == rhs.day
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.day)
  }
}
