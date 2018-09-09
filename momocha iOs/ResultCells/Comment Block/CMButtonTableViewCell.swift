//
//  CMButtonTableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 30/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class CMButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var more: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
