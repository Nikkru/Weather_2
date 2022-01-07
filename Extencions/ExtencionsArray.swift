//
//  ExtencionsArray.swift
//  Weather
//
//  Created by Nikolai Krusser on 04.01.2022.
//

import Foundation

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}
