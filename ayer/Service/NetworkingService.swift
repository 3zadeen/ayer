//
//  NetworkingService.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation
import Combine

class NetworkingService {
    
    static let shared = NetworkingService()
    static let urlSession = URLSession.shared
    
    typealias Handler<T> = (Result<T, Error>) -> Void
    
    private init() {
        
    }
    
    
    static func fetchCurrentWeatherData(userLocationCordinates: UserLocationCoordinate, forCity city: String, completionHandler: @escaping Handler<WeatherData>) {
        
        let path = "/data/2.5/\(Query.weather)"
        var endpoint = Endpoint(path: path)
        
        if (city.isEmpty) {
            let lat = String(userLocationCordinates.latitude)
            let lon = String(userLocationCordinates.longitude)
            endpoint.queryItems.append(URLQueryItem(name: "lat", value: lat))
            endpoint.queryItems.append(URLQueryItem(name: "lon", value: lon))
        } else {
            endpoint.queryItems.append(URLQueryItem(name: "q", value: city))
        }
        
        endpoint.queryItems.append(URLQueryItem(name: "units", value: TemperatureUnit.metric.rawValue))
        
        guard let url = endpoint.url else {return}
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
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
    
    
    static func fetchWeeklyWeatherData(userLocationCordinates: UserLocationCoordinate) -> AnyPublisher<WeeklyWeatherList, APIError> {
        
        let path = "/data/2.5/\(Query.forecast)"
        var endpoint = Endpoint(path: path)
        
        let lat = String(userLocationCordinates.latitude)
        let lon = String(userLocationCordinates.longitude)
        
        endpoint.queryItems.append(URLQueryItem(name: "lat", value: lat))
        endpoint.queryItems.append(URLQueryItem(name: "lon", value: lon))
        endpoint.queryItems.append(URLQueryItem(name: "units", value: TemperatureUnit.metric.rawValue))
        
        guard let url = endpoint.url else {
            let error = APIError.networkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let task = urlSession.dataTaskPublisher(for: URLRequest(url: url)).mapError { error in
            APIError.networkError(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { jsonResponse in
            
            Just(jsonResponse.data).decode(type: WeeklyWeatherList.self, decoder: decoder)
                .mapError { error in
                    APIError.parsingError(description: error.localizedDescription)
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
        
        return task
        
    }
    
    
    
    static func getIconData(iconName: String, completionHandler: @escaping Handler<Data>) {
        let path = "/img/w/\(iconName).png"
        var endpoint = Endpoint(path: path)
        endpoint.queryItems.removeAll()
        
        guard let url = endpoint.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(data))
            }
        }.resume()
    }
    
}
