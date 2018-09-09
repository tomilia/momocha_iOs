//
//  nameCellTableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 26/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class nameCellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
