//
//  CityModel.swift
//  Weather
//
//  Created by Nikolai Krusser on 03.01.2022.
//

import Foundation

class CityModel: NSObject {
    
    var title: String?
    var emblemURL: String?
    
    init(dict: [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
}
