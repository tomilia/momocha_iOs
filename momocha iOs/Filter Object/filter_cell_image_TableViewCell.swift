//
//  filter_cell_image_TableViewCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 22/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//


import UIKit
protocol CustomCellDelegate : class {
    func cellButtonTapped(sc: [Int])
}
class filter_cell_image_TableViewCell: UITableViewCell {
 

    
    var delegate: CustomCellDelegate?
    let estimateWidth = 110.0
    let cellMarginSize = 3.0
    var name:[String] = []
    var images:[UIImage] = []
    var selectedCell = [Int]()
    @IBOutlet weak var titleLabel: UILabel!
    

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
       self.collectionView.allowsMultipleSelection = true
    self.collectionView!.register(UINib(nibName:"locationcellwithimageCollectionViewCell", bundle:nil),forCellWithReuseIdentifier: "locationimageCell")
        
        // Initialization code
    }
    /*
     func setupGridView(){
     
     var flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
     flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
     flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
     
     
     
     }
     */

    func reloadData(title:String, names:[String],images:[UIImage]) {
        //设置标题
        self.titleLabel.text = title
        //保存图片数据
        self.name = names
        self.images = images
        //collectionView重新加载数据
        self.collectionView.reloadData()
        
        //更新collectionView的高度约束
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        heightConstraint.constant = contentSize.height
        
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
 extension filter_cell_image_TableViewCell: UICollectionViewDataSource{
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "extra_item_service",for: indexPath) as! locationcellwithimageCollectionViewCell
    cell.m_label.text = name[indexPath.item]
    cell.m_image.image = images[indexPath.item]
    return cell
 
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
return name.count
 }
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 let cell = collectionView.cellForItem(at: indexPath)!
 selectedCell.append(indexPath.item+1)
   delegate?.cellButtonTapped(sc: selectedCell)
 }
 
 func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
 let cell = collectionView.cellForItem(at: indexPath)!

 if selectedCell.contains(indexPath.item + 1) {
 selectedCell.remove(at: selectedCell.index(of: indexPath.item+1)!)
 delegate?.cellButtonTapped(sc: selectedCell)
 }
 
 }
 
 
 }
 
 extension filter_cell_image_TableViewCell: UICollectionViewDelegateFlowLayout{
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 let width = self.calculateWidth()
 return CGSize(width: width,height: width)
 }
    func calculateWidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount:CGFloat = 3.0
        print("cell count",cellCount*estimatedWidth+((cellCount+1) * CGFloat(cellMarginSize)))
        
        let margin = CGFloat(cellMarginSize * 3)
        let width = (self.collectionView.frame.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
 }

