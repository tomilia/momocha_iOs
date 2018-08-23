//
//  locationcellwithimageCollectionViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 22/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class locationcellwithimageCollectionViewCell: UICollectionViewCell {

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
     override var isSelected: Bool{
        didSet{
            if self.isSelected{
                /*self.contentView.backgroundColor = UIColor(red: 52/256, green: 96/256, blue:96/256, alpha: 1)*/self.contentView.layer.cornerRadius = 10.0;
                    self.contentView.layer.borderWidth = 3.0;
                self.contentView.layer.borderColor = UIColor(red: 52/256, green: 96/256, blue:96/256, alpha: 1).cgColor;
                self.contentView.layer.masksToBounds = true;
                self.test.backgroundColor = UIColor(red: 52/256, green: 96/256, blue:96/256, alpha: 1)
                self.test.layer.cornerRadius = 4.0;
                self.test.layer.masksToBounds = true;
                /*    self.layer.shadowColor = UIColor.black.cgColor;self.layer.shadowOffset = CGSize(width: 0, height: 2.0)self.layer.shadowRadius = 2.0;self.layer.shadowOpacity = 0.5;self.layer.masksToBounds = false;self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPathself.m_label.textColor = UIColor.white*/
                self.test.isHidden  = false
                
            }
            else
            {
                self.contentView.layer.cornerRadius = 10.0;
                self.contentView.layer.borderWidth = 1.0;
                self.contentView.layer.borderColor = UIColor.clear.cgColor;
                self.contentView.layer.masksToBounds = true;
                /*self.transform = CGAffineTransform.identityself.contentView.backgroundColor = UIColor.clearself.layer.shadowColor = UIColor.clear.cgColor;self.layer.masksToBounds = trueself.m_label.textColor = UIColor.darkGray*/self.test.isHidden  = true
                
            }
            
        }
        
    }

}
