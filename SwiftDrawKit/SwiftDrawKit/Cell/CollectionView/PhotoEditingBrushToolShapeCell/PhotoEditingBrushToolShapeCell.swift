//
//  PhotoEditingBrushToolShapeCell.swift
//  SwiftDrawKit
//
//  Created by Jaydeep Godhani on 03/06/25.
//  Copyright © 2025 JG. All rights reserved.
//

import UIKit

class PhotoEditingBrushToolShapeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let xibName = "PhotoEditingBrushToolShapeCell"
    static let cellIdentifier = "PhotoEditingBrushToolShapeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    func setData(data: MagicBrushModel) {
        self.imageView.image = UIImage(named: data.icon)
    }
    
}
