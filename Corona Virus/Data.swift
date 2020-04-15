//
//  Data.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 15/04/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import Foundation
import SwiftUI

struct Case: Decodable, Identifiable {
    let id = UUID()
    var cases: Double
    var deaths: Double
    var updated: Double
    var recovered: Double
    var active: Double
    
    init(
        cases: Double = 0,
        deaths: Double = 0,
        updated: Double = 0,
        recovered: Double = 0,
        active: Double = 0) {
        
        self.cases = cases
        self.deaths = deaths
        self.updated = updated
        self.recovered = recovered
        self.active = active
    }
}

struct Details: Decodable, Identifiable {
    let id = UUID()
    var country: String
    var cases: Double
    var deaths: Double
    var recovered: Double
    var critical: Double
    var casesPerOneMillion: Double?
    var deathsPerOneMillion: Double?
    var todayCases: Double?
    var todayDeaths: Double?
}

//func getDate(time: Double) -> String {
//    let date = Double(time / 1000)
//    let format = DateFormatter()
//    format.dateFormat = "MMM - dd - YYYY hh:mm a"
//    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
//}
//
//func getValue(data: Double) -> String {
//    let format = NumberFormatter()
//    format.numberStyle = .decimal
//    return format.string(for: data)!
//}


