//
//  GradientView.swift
//  Weather
//
//  Created by Nikolai Krusser on 10.11.2021.
//

import UIKit

@IBDesignable class GradientView: UIView {

    // Начальный цвет градиента
    @IBInspectable var startColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
        didSet {
            self.updateColors()
        }
    }
    // Конечный цвет градиента
    @IBInspectable var endColor: UIColor = #colorLiteral(red: 0.1075053638, green: 0.4476296627, blue: 0.6019789023, alpha: 1) {
        didSet {
            self.updateColors()
        }
    }
    // Начало градиента
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    // Конец градиента
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }
    // Точка начала градиента
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    // Точка конца градиента
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }

    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    func updateLocations() {
        self.gradientLayer.locations = [self.startLocation as NSNumber,
                                        self.endLocation as NSNumber]
    }
        
    func updateColors() {
        self.gradientLayer.colors = [self.startColor.cgColor,
                                     self.endColor.cgColor]
    }

    func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }

    func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
}

