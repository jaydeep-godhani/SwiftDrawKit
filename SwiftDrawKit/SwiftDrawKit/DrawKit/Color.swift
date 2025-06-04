//
//  Color.swift
//  SwiftDrawKit
//
//  Created by Jaydeep Godhani on 03/06/25.
//  Copyright © 2025 JG. All rights reserved.
//


import UIKit

public struct Color : Codable {
    private var red: CGFloat = 0.0
    private var green: CGFloat = 0.0
    private var blue: CGFloat = 0.0
    private var alpha: CGFloat = 0.0

    public var uiColor: UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    public init(_ uiColor: UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

public enum BlendMode: String, Codable {
    case normal = "normal"
    case clear = "clear"
    
    var cgBlendMode: CGBlendMode {
        switch self {
        case .normal:
            return .normal
        case .clear:
            return .clear
        }
    }
}
