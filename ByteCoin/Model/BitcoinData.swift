//
//  BitcoinData.swift
//  ByteCoin
//
//  Created by Anna Sibirtseva on 05/12/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    let last: Double
    let averages: Averages
    let open: Open
    
}

struct Averages: Codable {
    let day: Double
    let week: Double
    let month: Double
}

struct Open: Codable {
    let hour: Double
    let day: Double
}
