//
//  WeatherData.swift
//  Clima
//
//  Created by Oybek on 1/28/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
 
struct WeatherData: Codable {
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
}
struct Weather: Codable {
    var description: String
    var id: Int
}
