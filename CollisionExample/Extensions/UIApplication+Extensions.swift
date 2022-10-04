//
//  UIApplication+Extensions.swift
//  CollisionExample
//
//  Created by Ray on 2022/10/05.
//

import UIKit

extension UIApplication {
    var windowScene: UIWindowScene? {
        windows.first(where: { $0.isKeyWindow })?.windowScene
    }
}
