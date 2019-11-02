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
    
    @Published var dataSource: [DailyWeatherViewModel] = []
    
    private var disposables = Set<AnyCancellable>()
    
    @Published var city: String = ""
    
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
    
    private var cancellable: AnyCancellable? = nil
    
    var name: String {
        return weatherData?.name ?? ""
    }
    
    init() {
        
        cancellable = AnyCancellable(
        $city.removeDuplicates()
            .debounce(for: .seconds(3), scheduler: DispatchQueue.main)
          .sink { searchText in
            self.fetchCurrentWeatherData(city: searchText)
            self.fetchWeeklyWeatherData(city: searchText)
        })
        
        fetchCurrentWeatherData(city: city)
        fetchWeeklyWeatherData(city: city)
    }
    
    
    func fetchCurrentWeatherData(city: String) {
        let userLocationCoordinates = UserLocationCoordinate(latitude: 3, longitude: 101)
        NetworkingService.fetchCurrentWeatherData(userLocationCordinates: userLocationCoordinates, forCity: city) { [weak self] response in
            
            guard let self = self else {return}
            
            switch response {
                case .success(let response):
                    
                    self.weatherData = response
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchWeeklyWeatherData(city: String) {
        let userLocationCoordinates = UserLocationCoordinate(latitude: 3, longitude: 101)
        
        NetworkingService.fetchWeeklyWeatherData(userLocationCordinates: userLocationCoordinates, forCity: city)
            .map { response in
                response.list.map(DailyWeatherViewModel.init)
            }
            .map(Array.uniqued)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.dataSource = []
                case .finished:
                  break
                }
            }, receiveValue: { [weak self] weatherData in
                guard let self = self else { return }
                self.dataSource = weatherData()
            })
            .store(in: &disposables)
    }
    
    
}
