//
//  Location.swift
//  momocha iOs
//
//  Created by Tommy Lee on 6/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class Location: UIView {

    @IBOutlet weak var eeView: UIView!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var location: UILabel!
    override init(frame: CGRect){
        super.init(frame:frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
}
