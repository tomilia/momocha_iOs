//
//  TableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 30/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class CMTableCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpAvatar()
        // Initialization code
    }
    func setUpAvatar(){
        self.avatar.layer.cornerRadius = (self.avatar.image?.size.width)! / 2
         self.avatar.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
