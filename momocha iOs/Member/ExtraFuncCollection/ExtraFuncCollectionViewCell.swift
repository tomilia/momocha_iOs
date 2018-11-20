//
//  ExtraFuncCollectionViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 21/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class ExtraFuncCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var m_image: UIImageView!
    
    @IBOutlet weak var m_label: UILabel!
    
    @IBOutlet weak var test: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        // Specify you want _full width_
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        // Calculate the size (height) using Auto Layout
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        
        // Assign the new size to the layout attributes
        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }
    
    
}

