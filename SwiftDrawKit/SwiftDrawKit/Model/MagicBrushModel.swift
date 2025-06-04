//
//  MagicBrushModel.swift
//  SwiftDrawKit
//
//  Created by Jaydeep Godhani on 03/06/25.
//  Copyright © 2025 JG. All rights reserved.
//

import Foundation

struct MagicBrushModel {
    let id: Int
    let icon: String
    let type: BrushShapeType
}

enum BrushShapeType {
    case draw
    case line
    case ellipse
    case rect
}
