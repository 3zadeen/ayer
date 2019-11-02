//
//  WeeklyWeatherViewModel.swift
//  ayer
//
//  Created by Ezaden Seraj on 31/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class WeeklyWeatherViewModel: ObservableObject {
    
    
//    @Published var dataSource: [DailyWeatherViewModel] = []
    
//    private var disposables = Set<AnyCancellable>()
    
    
//    init() {
//        fetchWeeklyWeatherData()
//    }
    
    
//    func fetchWeeklyWeatherData() {
//        let userLocationCoordinates = UserLocationCoordinate(latitude: 3, longitude: 101)
//
//        NetworkingService.fetchWeeklyWeatherData(userLocationCordinates: userLocationCoordinates)
//            .map { response in
//                response.list.map(DailyWeatherViewModel.init)
//            }
//            .map(Array.uniqued)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] value in
//                guard let self = self else { return }
//                switch value {
//                case .failure:
//                  self.dataSource = []
//                case .finished:
//                  break
//                }
//            }, receiveValue: { [weak self] weatherData in
//                guard let self = self else { return }
//                self.dataSource = weatherData()
//            })
//            .store(in: &disposables)
//    }
    
}
