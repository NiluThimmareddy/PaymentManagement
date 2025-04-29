//
//  UIView+Extension.swift
//  PaymentManagement
//
//  Created by ToqSoft on 28/04/25.
//

import Foundation
import UIKit

@IBDesignable
class DesignableLabel: UILabel { }

@IBDesignable
class DesignableButton: UIButton { }

@IBDesignable
class DesignableImageView: UIImageView { }

@IBDesignable
class DesignableView: UIView { }

@IBDesignable
class DesignableScrollView: UIScrollView { }

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    func applyCardStyle(cornerRadius: CGFloat = 15,
                        shadowOffset: CGSize = CGSize(width: 0, height: 1),
                        shadowRadius: CGFloat = 2,
                        shadowOpacity: Float = 0.5) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = nil // or .none
        self.layer.shadowOpacity = shadowOpacity
    }
}
