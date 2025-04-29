//
//  UITextField+Extension.swift
//  PaymentManagement
//
//  Created by ToqSoft on 28/04/25.
//

import Foundation
import UIKit

extension UITextField {
    func shake(duration: CFTimeInterval = 0.5, pathLength: CGFloat = 5) {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = [
            layer.position.x - pathLength,
            layer.position.x + pathLength,
            layer.position.x - pathLength * 0.7,
            layer.position.x + pathLength * 0.7,
            layer.position.x
        ]
        animation.duration = duration
        layer.add(animation, forKey: "shake")
    }
}
