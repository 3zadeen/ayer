//
//  Array+Extension.swift
//  ayer
//
//  Created by Ezaden Seraj on 31/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
