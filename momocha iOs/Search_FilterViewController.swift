//
//  Search_FilterViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 17/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
protocol Search_FilterViewControllerDelegate: class {
    func removeBlurredBackgroundView()
    func showNav()
}
class Search_FilterViewController: UIViewController{
    var selectedCell = [IndexPath]()
    weak var delegate: Search_FilterViewControllerDelegate?
    let arrayx = ["AAA","BBB","CCC","DDD","EEE","FFF","GGG"]
    var estimateWidth = 120.0
    var cellMarginSize = 1.0

    @IBOutlet weak var sp_HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var place_table: UITableView!
    @IBOutlet weak var m_nav: UINavigationItem!

    @IBAction func m_return(_ sender: Any) {
        shadow_view.isHidden = true
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
        delegate?.showNav()
    }
    @objc func back(sender: UIBarButtonItem){
        shadow_view.isHidden = true
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
        delegate?.showNav()
    }

    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var shadow_view: UIView!
    
    @IBOutlet weak var stationview: UICollectionView!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*mx_nav.titleTextAttributes = [kCTFontAttributeName as NSAttributedStringKey: UIFont(name: "HelveticaNeue-Light",size: 22)!]*/
        let newBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel1x"), style: UIBarButtonItemStyle.done, target: self, action: #selector(Search_FilterViewController.back(sender:)))

        self.collectionview.delegate = self
        //colection delegate
        self.collectionview.dataSource = self
        //register xib
        let height = self.collectionview.collectionViewLayout.collectionViewContentSize.height
        print("sp2",height)
        self.collectionview.register(UINib(nibName: "filter_cell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        self.collectionview.allowsSelection = true
        self.collectionview.allowsMultipleSelection = true
        //Setup Grid View
        self.stationview.delegate = self
        self.stationview.dataSource = self
        self.stationview.register(UINib(nibName: "locationcell", bundle: nil), forCellWithReuseIdentifier: "locationCell")
        self.stationview.allowsSelection = true
        
        self.setupGridView()
 
        //self.setupBlur()
        // Do any additional setup after loading the view.
    }
    func setupBlur(){
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            view.backgroundColor = .black
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionview.reloadData()
            self.stationview.reloadData()
        }
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupGridView(){
        
        var flow = collectionview?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        flow = stationview?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        
        let height = self.collectionview.collectionViewLayout.collectionViewContentSize.height
        print("sp",height)

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Search_FilterViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionview
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! filter_cell

              return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as! locationcell
              return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == collectionview
        {
            return self.arrayx.count
        }
        else
        {
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        selectedCell.append(indexPath)
        print(selectedCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        if selectedCell.contains(indexPath) {
            selectedCell.remove(at: selectedCell.index(of: indexPath)!)
print(selectedCell)
        }
    }
    
    
}

extension Search_FilterViewController: UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = self.calculateWidth()
        
        return CGSize(width: width,height: width)
    }
    func calculateWidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width) / estimatedWidth)
        print("cell count",cellCount*estimatedWidth+((cellCount+1) * CGFloat(cellMarginSize)))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}
extension UILabel{
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
