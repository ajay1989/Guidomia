//
//  Extension.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation
import UIKit

extension UIColor {
    
    //UIColor hex code
    convenience init(hex: String,
                     alpha: CGFloat = 1) {
        
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let redColor = (rgbValue & 0xff0000) >> 16
        let greenColor = (rgbValue & 0xff00) >> 8
        let blueColor = rgbValue & 0xff
        self.init(
            red: CGFloat(redColor) / 0xff,
            green: CGFloat(greenColor) / 0xff,
            blue: CGFloat(blueColor) / 0xff,
            alpha: alpha
        )
    }
}
