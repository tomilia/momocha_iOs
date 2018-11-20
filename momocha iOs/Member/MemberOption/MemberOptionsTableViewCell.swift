//
//  ServiceTableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 27/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class MemberOptionsTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource  {
    var options=["邀請朋友","意見反饋","我要投訴"]
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var delegate: cmsegueDelegator!
    @IBOutlet weak var optionsTable: UIDynamicTableView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        //setUpTable()
        print("setping")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func tableViewHeight() -> CGFloat {
        optionsTable.layoutIfNeeded()
        return optionsTable.contentSize.height
        
    }
    /*
    func tableViewHeight() -> CGFloat {
        optionsTable.layoutIfNeeded()
        return optionsTable.contentSize.height
        
    }*/
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 15, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "GenJyuuGothicL-Monospace-Light", size: 22)
        headerLabel.textColor = UIColor(red: 107/256, green: 107/256, blue: 107/256, alpha: 1)
        headerLabel.text = "評論"
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }*/
    /*
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
 */
    /*
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        optionsTable.layoutIfNeeded()
        let screenWidth = UIScreen.main.bounds.width
        print("cmaa",screenWidth)
        print("diff",optionsTable.frame.width,self.bounds.width)
        let footerView = UIView(frame:CGRect(x: 0,y: 0,width: screenWidth,height: 40))
        footerView.addSubview(moreButton(screenWidth: screenWidth))
        footerView.addSubview(separator(screenWidth: screenWidth))
        
        footerView.addSubview(writeButton(screenWidth: screenWidth))
        
        return footerView
    }
 */
    @objc func moreComment(sender: Any?)
    {
        var mydata = "Anydata you want to send to the next controller"
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(myData:mydata as AnyObject)
        }
    }
    
    func moreButton(screenWidth: CGFloat) -> UIButton{
        
        
        let moreButton = UIButton(type: .custom)
        moreButton.setTitle("更多評論", for: .normal)
        moreButton.addTarget(self, action: #selector(moreComment(sender:)), for: .touchUpInside)
        moreButton.setTitleColor(UIColor(red: 54/256, green: 163/256, blue: 162/256, alpha: 1), for: .normal)
        moreButton.backgroundColor = UIColor.white
        moreButton.frame = CGRect(x: 0,y: 0,width: screenWidth / 2 - 0.5,height: 50)
        return moreButton
    }
    /*
    func separator(screenWidth: CGFloat) -> UIView{
        let separator = UIView()
        separator.frame = CGRect(x: screenWidth / 2 - 0.5,y: 50 / 4,width: 1 ,height: 25)
        separator.backgroundColor = UIColor(red: 200/256, green: 200/256, blue: 200/256, alpha: 1)
        return separator
    }
 */
    func writeButton(screenWidth: CGFloat) ->UIButton {
        let writeButton = UIButton(type: .custom)
        writeButton.setTitle("寫評論", for: .normal)
        writeButton.addTarget(self, action: "loginAction", for: .touchUpInside)
        writeButton.setTitleColor(UIColor(red: 54/256, green: 163/256, blue: 162/256, alpha: 1), for: .normal)
        writeButton.backgroundColor = UIColor.white
        writeButton.frame = CGRect(x: screenWidth / 2 + 0.5,y: 0,width: screenWidth / 2,height: 50)
        return writeButton
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        optionsTable.delegate = self
        optionsTable.dataSource = self
        optionsTable.register(UINib(nibName: "options", bundle: nil), forCellReuseIdentifier: "optionsCell")
        print("hh",tableViewHeight())
        optionsTable.separatorStyle = .none
        // Initialization code
      //  setUpTable()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell") as! optionsTableViewCell
    
       cell.name_label.text = options[indexPath.item]
        print("diff",optionsTable.frame.width,self.bounds.width)
        
        return cell
    }
    func reloaddata(){
        optionsTable.reloadData()
    }
    func setUpTable(){
     /*   self.optionsTable?.dataSource = self
        self.optionsTable?.delegate = self
        
        self.optionsTable?.register(UINib(nibName: "CMTableCell", bundle: nil), forCellReuseIdentifier: "cmCell")
        optionsTable.separatorStyle = .none
        optionsTable.rowHeight = UITableViewAutomaticDimension
        
        optionsTable.estimatedRowHeight = 50
        
        // optionsTable.frame = CGRect(x: optionsTable.frame.origin.x, y: optionsTable.frame.origin.y,width: optionsTable.frame.size.width,height:  optionsTable.frame.size.height+((3 - 1)*44));
        */
        
        self.addSubview(optionsTable!)
        
        optionsTable.layoutIfNeeded()
        /*
        tableView(optionsTable, viewForFooterInSection: 0)
 */
      //  print("tvh",tableViewHeight())
    }
    /*
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
    */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("dfs")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        footerFixer()
    }
    func footerFixer(){
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return options.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
