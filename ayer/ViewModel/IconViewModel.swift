//
//  RemoteIconURL.swift
//  ayer
//
//  Created by Ezaden Seraj on 31/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation
import Combine

class IconViewModel: ObservableObject {
    
    @Published var data = Data()
    
    init(iconName: String) {
        getIconData(iconName: iconName)
    }
    
    typealias Handler<T> = (Result<T, Error>) -> Void
    
    func getIconData(iconName: String) {
        NetworkingService.getIconData(iconName: iconName) { response in
            switch response {
                case .success(let response):
                    
                    self.data = response
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
