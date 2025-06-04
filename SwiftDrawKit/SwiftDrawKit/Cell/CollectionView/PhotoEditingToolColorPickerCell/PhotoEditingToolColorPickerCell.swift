//
//  PhotoEditingToolColorPickerCell.swift
//  SwiftDrawKit
//
//  Created by Jaydeep Godhani on 03/06/25.
//  Copyright © 2025 JG. All rights reserved.
//

import UIKit

class PhotoEditingToolColorPickerCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    static let xibName = "PhotoEditingToolColorPickerCell"
    static let cellIdentifier = "PhotoEditingToolColorPickerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    func setData(data: BrushColorModel) {
        self.colorView.backgroundColor = UIColor(hex: data.color)
        self.colorView.layer.borderWidth = 2
    }
    
}
