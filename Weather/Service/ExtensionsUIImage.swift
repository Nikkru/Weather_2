//
//  ExtensionsUIImage.swift
//  Weather
//
//  Created by Nikolai Krusser on 02.01.2022.
//

import UIKit

extension  UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
