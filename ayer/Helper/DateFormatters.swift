//
//  DateFormatters.swift
//  ayer
//
//  Created by Ezaden Seraj on 31/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation


let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter
}()


let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter
}()
