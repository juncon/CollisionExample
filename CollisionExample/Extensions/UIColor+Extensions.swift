//
//  UIColor+Extensions.swift
//  CollisionExample
//
//  Created by Ray on 2022/10/05.
//

import UIKit

extension UIColor {
    static var random: UIColor? {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
