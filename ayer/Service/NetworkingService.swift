//
//  NetworkingService.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation


class NetworkingService {
    
    static let shared = NetworkingService()
    static let urlSession = URLSession.shared
    
    typealias Handler<T> = (Result<T, Error>) -> Void
    
    private init() {
        
    }
    
    
    static func fetchCurrentWeatherData(userLocationCordinates: UserLocationCoordinate, completionHandler: @escaping Handler<WeatherData>) {
        let path = "/data/2.5/\(Query.weather)"
        var endpoint = Endpoint(path: path)
        
        let lat = String(userLocationCordinates.latitude)
        let lon = String(userLocationCordinates.longitude)
        
        endpoint.queryItems.append(URLQueryItem(name: "lat", value: lat))
        endpoint.queryItems.append(URLQueryItem(name: "lon", value: lon))
        endpoint.queryItems.append(URLQueryItem(name: "units", value: TemperatureUnit.metric.rawValue))
        
        guard let url = endpoint.url else {return}
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let weatherList = try decoder.decode(WeatherData.self, from: data)
                        completionHandler(.success(weatherList))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
    static func fetchWeatherData(userLocationCordinates: UserLocationCoordinate, completionHandler: @escaping Handler<WeatherData>) {
        
        let path = "/data/2.5/\(Query.forecast)"
        var endpoint = Endpoint(path: path)
        
        let lat = String(userLocationCordinates.latitude)
        let lon = String(userLocationCordinates.longitude)
        
        endpoint.queryItems.insert(URLQueryItem(name: "lat", value: lat), at: 0)
        endpoint.queryItems.insert(URLQueryItem(name: "lon", value: lon), at: 1)
        
        guard let url = endpoint.url else {return}
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let weatherList = try decoder.decode(WeatherData.self, from: data)
                        completionHandler(.success(weatherList))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
}
