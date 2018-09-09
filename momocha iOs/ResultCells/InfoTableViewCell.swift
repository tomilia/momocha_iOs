//
//  InfoTableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 26/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate  {
 
    @IBOutlet weak var subTable: UITableView!
    
    
    var dataArr:[String?] = []
    func tableViewHeight() -> CGFloat {
        subTable.layoutIfNeeded()
        return subTable.contentSize.height
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        setUpTable()
        print("setping")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTable()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoTableViewCell") as! InfoInsideTableViewCell
        
        cell.icon.image = #imageLiteral(resourceName: "home-s1x")
        cell.label.text = dataArr[indexPath.item]
        cell.label.sizeToFit()
        return cell
    }
    func setUpTable(){
        self.subTable?.delegate = self
        self.subTable?.dataSource = self
        self.subTable?.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "infoTableViewCell")
        subTable.estimatedRowHeight = 44
        subTable.rowHeight = UITableViewAutomaticDimension
        subTable.separatorStyle = .none

        self.addSubview(subTable!)
    }
    override func draw(_ rect: CGRect) {
        //线宽
        let lineWidth = 1 / UIScreen.main.scale
        //线偏移量
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
        //线条颜色
        let lineColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: 0, dy: lineAdjustOffset)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: drawingRect.maxX, y: drawingRect.maxY))
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(lineColor.cgColor)
        //设置笔触宽度
        context.setLineWidth(lineWidth)
        
        //绘制路径
        context.strokePath()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("dfs")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    
}
