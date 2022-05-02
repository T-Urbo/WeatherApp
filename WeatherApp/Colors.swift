//
//  Colors.swift
//  WeatherApp
//
//  Created by Timothey Urbanovich on 26/04/2022.
//

import UIKit
import Foundation

extension ViewController {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 66.0/255.0, green: 84.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 90.0/255.0, green: 66.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}
