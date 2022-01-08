//
//  Weather.swift
//  Weather
//
//  Created by Nikolai Krusser on 08.01.2022.
//

import Foundation

class Weather: Decodable {
    
    var date = 0.0
    var temp = 0.0
    var pressure = 0.0
    var humidity = 0
    var weatherName = ""
    var weatherIcon = ""
    var windSpeed = 0.0
    var windDegrees = 0.0
    var city = ""
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case wind
    }
    
    enum MainKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
    }
    
    enum WeatherKeys: String, CodingKey {
        case main
        case icon
    }
    
    enum WindKeys: String, CodingKey {
        case speed
        case deg
    }
    
    convenience required init(from decoder: Decoder) throws {
            self.init()
    }
}

class WeatherResponse: Decodable {
    let list: [Weather]
}
