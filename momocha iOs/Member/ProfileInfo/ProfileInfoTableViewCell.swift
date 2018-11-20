//
//  ProfileInfoTableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 18/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var user_image: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var m_cash: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        user_image.layer.borderWidth = 0.1
        user_image.layer.masksToBounds = false

        user_image.layer.cornerRadius = user_image.frame.height/2.2
        user_image.clipsToBounds = true
        // Initialization code
    }
    @IBOutlet weak var x_label: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
