//
//  filter_cell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 18/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class filter_cell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setData(text: String){
        self.textLabel.text = text
    }
    override var isSelected: Bool{
        didSet{

            if isSelected
            {
                 let tempImg = image.image?.withRenderingMode(.alwaysTemplate)
                image.image = tempImg
                image.tintColor = UIColor.yellow
            }
            else{
                let tempImg = image.image?.withRenderingMode(.alwaysTemplate)
                image.image = tempImg
                image.tintColor = UIColor.lightGray
            }
        }
    }
}
