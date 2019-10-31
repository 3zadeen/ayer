//
//  EndPoint.swift
//  ayer
//
//  Created by Ezaden Seraj on 30/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem]
    private let scheme = "https"
    private let host = "api.openweathermap.org"
    private let apiKey = "b0b05ca31728f01f7226a55b019b3506"
    
    init(path: String) {
        self.path = path
        self.queryItems = [URLQueryItem(name: "appid", value: apiKey)]
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
