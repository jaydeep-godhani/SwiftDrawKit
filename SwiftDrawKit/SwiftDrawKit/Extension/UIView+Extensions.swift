//
//  UIView+Extensions.swift
//  SwiftDrawKit
//
//  Created by Jaydeep Godhani on 03/06/25.
//  Copyright © 2025 JG. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var iscircleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadiusV
        }
        set {
            cornerRadiusV = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadiusV
        }
    }
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
}
