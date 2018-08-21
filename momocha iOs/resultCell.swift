//
//  resultCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 13/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class resultCell: UICollectionViewCell {

    @IBOutlet weak var m_image: UIImageView!
    @IBOutlet weak var tagview: UICollectionView!
    @IBOutlet weak var m_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.m_image.image = #imageLiteral(resourceName: "2-1")
        // Initialization code
    }

}
