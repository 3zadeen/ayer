//
//  String+Extension.swift
//  ayer
//
//  Created by Ezaden Seraj on 31/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
