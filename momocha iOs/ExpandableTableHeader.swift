//
//  ExpandableTableHeader.swift
//  momocha iOs
//
//  Created by Tommy Lee on 18/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

protocol ExpandHeaderViewDelegate {
    func toggleSection(header: ExpandableTableHeader, section: Int)
}

class ExpandableTableHeader: UITableViewHeaderFooterView{
    var delegate: ExpandHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(selectHeaderAction)))
    }
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! ExpandableTableHeader
        delegate?.toggleSection(header: self, section: cell.section)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func customInit(title: String, section: Int, delegate: ExpandHeaderViewDelegate){
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.darkGray
    }
}
