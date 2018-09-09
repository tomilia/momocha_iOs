//
//  ServiceTableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 27/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class ItemServiceTableViewCell: UITableViewCell {
    
    
    let estimateWidth = 50.0
    let cellMarginSize = 10.0
    var name:[String] = []
    var images:[UIImage] = []
    var selectedCell = [Int]()
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout

        collectionViewLayout?.invalidateLayout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.allowsMultipleSelection = true
        self.collectionView!.register(UINib(nibName:"ItemServiceCell", bundle:nil),forCellWithReuseIdentifier: "item_service_identifier")
        self.collectionView.isScrollEnabled = false
        
        // Initialization code
    }

    /*
     func setupGridView(){
     
     var flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
     flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
     flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
     
     
     
     }
     */
    
    func reloadData() {
        //设置标题
        
        //collectionView重新加载数据
        self.collectionView.reloadData()
        
        //更新collectionView的高度约束
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    //返回collectionView的单元格数量
    /* func collectionView(_ collectionView: UICollectionView,
     numberOfItemsInSection section: Int) -> Int {
     return 12
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
     
     let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 3))/2, height: 120)
     print("cellsize",cellSize)
     return cellSize
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
     {
     let sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
     return sectionInset
     }
     //返回对应的单元格
     func collectionView(_ collectionView: UICollectionView,
     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     print("pathx",collectionView)
     let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "locationimageCell",for: indexPath) as! locationcellwithimageCollectionViewCell
     
     return cell
     }
     */
    //绘制单元格底部横线
    override func draw(_ rect: CGRect) {
        //线宽
        let lineWidth = 1 / UIScreen.main.scale
        //线偏移量
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
        //线条颜色
        let lineColor = UIColor(red: 0xe0/255, green: 0xe0/255, blue: 0xe0/255, alpha: 1)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
    
        //创建一个矩形，它的所有边都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
        
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
    }
    
    
    
}
extension ItemServiceTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "item_service_identifier",for: indexPath) as! ItemServiceCell
        cell.Itemlabel.text = "中式按摩"
        cell.Itemview.layer.cornerRadius = 10.0
        cell.Itemview.layer.borderWidth = 1.0
        cell.Itemview.layer.borderColor = UIColor.clear.cgColor
        cell.Itemview.layer.masksToBounds = true
 cell.Itembutton.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.Itembutton.titleLabel?.lineBreakMode = .byTruncatingTail
        cell.Itembutton.layer.cornerRadius = 5
        cell.Itembutton.layer.borderWidth = 1
        cell.Itembutton.layer.borderColor = UIColor.clear.cgColor
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 6
    }
    
    
    
}

extension ItemServiceTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        return CGSize(width: collectionView.frame.size.width - 10,height: 80)
    }
    func calculateWidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount:CGFloat = 3.0
        
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.collectionView.frame.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        print("cell count",width)
        return width
    }
}
