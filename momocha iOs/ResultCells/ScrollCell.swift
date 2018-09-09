//
//  NameCell.swift
//  momocha iOs
//
//  Created by Tommy Lee on 24/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class ScrollCell: UITableViewCell {
    
    var imageArray=[#imageLiteral(resourceName: "3-1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "2-1")]
    var name:[String] = []
    let estimateWidth = 110.0
    let cellMarginSize = 3.0
    var selectedCell = [String]()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pagerView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.pagerView!.delegate = self
        self.pagerView!.dataSource = self
        self.pagerView!.register(UINib(nibName:"ViewPagerCell", bundle:nil),forCellWithReuseIdentifier: "ViewPagerCell")
        
  
        // Initialization code
    }
     /*
    public func returnSelected() -> Int{
        return selectedCell.count
    }
   
     func setupGridView(){
     
     var flow = collectionView?.pagerViewLayout as! UICollectionViewFlowLayout
     flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
     flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
     
     
     
     }
     */
    func reloadData(title:String, names:[String]) {
        //设置标题
        self.titleLabel.text = title
        //保存图片数据
        self.name = names
        //collectionView重新加载数据
        self.pagerView.reloadData()
        
        //更新collectionView的高度约束
        let contentSize = self.pagerView.collectionViewLayout.collectionViewContentSize
        heightConstraint.constant = contentSize.height
        
        self.pagerView.collectionViewLayout.invalidateLayout()
    }
    //返回collectionView的单元格数量
    /*func collectionView(_ collectionView: UICollectionView,
     numberOfItemsInSection section: Int) -> Int {
     return name.count
     }
     
     //返回对应的单元格
     func collectionView(_ collectionView: UICollectionView,
     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     print("pathx",collectionView)
     
     let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell",for: indexPath) as! locationcell
     cell.m_label.text = self.name[indexPath.item]
     return cell
     }
     */
    //绘制单元格底部横线
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("dfs")
    }
    
    
    
}
extension ScrollCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("viewPagers")
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewPagerCell",for: indexPath) as! ViewPagerCell
        let currentCGImage = self.imageArray[indexPath.item].cgImage
        let currentCIImage = CIImage(cgImage: currentCGImage!)
        
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")
        
        // set a gray value for the tint color
        filter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor")
        
        filter?.setValue(0.7, forKey: "inputIntensity")
        let outputImage = filter?.outputImage
        
        let context = CIContext()
        
        if let cgimg = context.createCGImage(outputImage!, from: (outputImage?.extent)!) {
            let processedImage = UIImage(cgImage: cgimg)
            print(processedImage.size)
            cell.images.image = processedImage
        }
        
        cell.images.contentMode = .scaleAspectFit
   
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.imageArray.count
    }
     /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        selectedCell.append(name[indexPath.item])
        print(selectedCell)
    }
   
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        if selectedCell.contains(name[indexPath.item]) {
            selectedCell.remove(at: selectedCell.index(of: name[indexPath.item])!)
            print(selectedCell)
        }
    }*/
    
    
}

extension ScrollCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = collectionView.frame.height
        return CGSize(width: collectionView.bounds.size.width,  height: CGFloat(kWhateverHeightYouWant))
    }
    func calculateWidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount:CGFloat = 3.0
        print("cell count",cellCount*estimatedWidth+((cellCount+1) * CGFloat(cellMarginSize)))
        
        let margin = CGFloat(cellMarginSize * 3)
        let width = (self.pagerView.frame.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}

