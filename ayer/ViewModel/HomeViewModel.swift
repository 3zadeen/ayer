//
//  HomeViewModel.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {

    
    @Published var weatherData = WeatherData()
    
    var temperature: String {
        return String(format: "%.1f°", weatherData?.main.temperature ?? 0)
    }
    
    var maxTemperature: String {
      return String(format: "%.1f", weatherData?.main.maximumTemp ?? 0)
    }
    
    var minTemperature: String {
      return String(format: "%.1f", weatherData?.main.minimumTemp ?? 0)
    }
    
    var humidity: String {
      return String(weatherData?.main.humidity ?? 0)
    }
    
    var pressure: String {
      return String(weatherData?.main.pressure ?? 0)
    }
    
    var description: String {
        let desc = weatherData?.weather.first?.description ?? ""
        return desc.capitalizingFirstLetter()
    }
    
    
    var name: String {
        return weatherData?.name ?? ""
    }
    
    init() {
        fetchCurrentWeatherData()
    }
    
    func fetchCurrentWeatherData() {
        let userLocationCoordinates = UserLocationCoordinate(latitude: 3, longitude: 101)
        NetworkingService.fetchCurrentWeatherData(userLocationCordinates: userLocationCoordinates) { [weak self] response in
            
            guard let self = self else {return}
            
            switch response {
                case .success(let response):
                    
                    self.weatherData = response
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
