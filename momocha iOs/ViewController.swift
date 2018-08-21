//
//  ViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 4/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource {

    
    let cellIdentifier = "cellIdentifier"

    @IBOutlet weak var suggestionCollection: UICollectionView!
    @IBOutlet weak var pagerDot: UIPageControl!
    @IBOutlet weak var viewPager: UIScrollView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var locationScroll: UIScrollView!
    @IBOutlet weak var suggestionScroll: UIScrollView!
    static var i = 0
    let location1=["title":"羅湖區","image":"1"]
    let location2=["title":"老街區","image":"2"]
    let location3=["title":"？？區","image":"3"]
    let location4=["title":"！！區","image":"4"]
    let suggestion1=["CHtitle":"XX按摩店"]
    let suggestion2=["CHtitle":"YY按摩店"]
    let suggestion3=["CHtitle":"ZZ按摩店"]
    var locationArray=[Dictionary<String,String>]()
    var suggestionArray=[Dictionary<String,String>]()
    var imageArray=[UIImage]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! suggestion
        
        cell.name_x.text = self.suggestionArray[indexPath.item]["CHtitle"]!
        cell.name_x.sizeToFit()
        cell.image.image = #imageLiteral(resourceName: "2-1")
        
        return cell
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //sidebar
        sideMenu()
        //topnavbar
        customizeNav()
        //first viewpager
        
        viewPager.isPagingEnabled=true
        viewPager.showsHorizontalScrollIndicator=false
        viewPager.delegate = self
        pagerDot.autoresizingMask = UIViewAutoresizing.flexibleBottomMargin
        pagerDot.frame = CGRect(x: view.frame.width * 0.25, y: self.viewPager.frame.height + 10 , width: view.frame.width * 0.5, height: 20)
        viewPagerload()
        
        
        locationScrollload()
       /*
        suggestionScroll.isPagingEnabled=true
        suggestionScroll.showsHorizontalScrollIndicator=false
        suggestionScroll.delegate = self
 */suggestionArray=[suggestion1,suggestion2,suggestion3]
        suggestionCollection.register(UINib(nibName: "suggestion", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        suggestionCollection.delegate = self
        suggestionCollection.dataSource = self
        //suggestionload()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
func viewPagerload(){
    imageArray=[#imageLiteral(resourceName: "3-1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "2-1")]
    
    viewPager.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
    viewPager.contentSize = CGSize(width: view.frame.width * CGFloat(imageArray.count), height: 200)
    
    for i in 0..<imageArray.count{
        let imageView = UIImageView()
        imageView.image=imageArray[i]
        imageView.contentMode = .scaleToFill
        let xPos=self.view.frame.width * CGFloat(i)
        imageView.frame=CGRect(x: xPos, y: 0, width: self.viewPager.frame.width, height: self.viewPager.frame.height)

        viewPager.contentSize.width=viewPager.frame.width * CGFloat(i + 1)

        viewPager.addSubview(imageView)
        }
    let scrollingTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.newStartScrolling), userInfo: nil, repeats: true)
    scrollingTimer.fire()
    }
    @objc func newStartScrolling()
    {
    
        if ViewController.i == imageArray.count {
            ViewController.i = 0
        }
        let x = CGFloat(ViewController.i) * viewPager.frame.size.width
        viewPager.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        ViewController.i += 1
    }
    func locationScrollload(){
       
        locationArray = [location1,location2,location3,location4]
        var frm: CGRect = locationScroll.frame
        locationScroll.frame = CGRect(x: frm.origin.x, y: frm.origin.y, width: view.frame.width, height: 128)
        locationScroll.contentSize=CGSize(width: 135 * CGFloat(locationArray.count),height: locationScroll.frame.height)
        locationScroll.showsVerticalScrollIndicator=false
        locationScroll.showsHorizontalScrollIndicator=false
        
        for (index,location) in locationArray.enumerated(){
            print(locationArray.count)
            
            if let Location = Bundle.main.loadNibNamed("Location", owner: self, options: nil)?.first as? Location{
                Location.eeView.dropShadow()
                Location.image.layer.cornerRadius = 5
                Location.image.image = #imageLiteral(resourceName: "3-1")
                Location.location.text = location["title"]
                
                Location.location.sizeToFit()
                /*

                Location.blur.layer.cornerRadius = 5
                Location.blur.clipsToBounds = true
                Location.image.layer.masksToBounds = true

           */
            Location.frame.size.width = 135
            Location.frame.origin.x = CGFloat(index) * 135
 
                 locationScroll.addSubview(Location)
            }
        }

        
    }
    func suggestionload(){
        
        var frm: CGRect = suggestionScroll.frame
        suggestionScroll.frame = CGRect(x: frm.origin.x, y: frm.origin.y, width: view.frame.width, height: 200)
        suggestionScroll.contentSize = CGSize(width: view.frame.width * CGFloat(suggestionArray.count), height: 200)
        print(suggestionArray.count)
        for (index,suggest) in suggestionArray.enumerated(){
            
            if let suggestion = Bundle.main.loadNibNamed("suggestion", owner: self, options: nil)?.first as? suggestion{
                
                suggestion.image.layer.cornerRadius = 5
                suggestion.image.image = #imageLiteral(resourceName: "2-1")
                suggestion.image.layer.masksToBounds = true
                suggestion.name_x.text = suggest["CHtitle"]
                suggestion.name_x.sizeToFit()
                suggestion.image.contentMode = .scaleToFill
                suggestionScroll.contentSize.width = suggestionScroll.frame.width * CGFloat(index + 1)
                suggestion.frame.size.width = 270
                suggestionScroll.clipsToBounds = false
                    suggestion.frame.origin.x = suggestion.frame.size.width * CGFloat(index)
             
            
                print(index ," ",suggestion.frame.origin.x)
                suggestionScroll.addSubview(suggestion)
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewPager == scrollView
        {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
            print(page)
         pagerDot.currentPage = Int(page)
            ViewController.i = Int(page)
        
        }
        else if suggestionScroll == scrollView
        {
    
            
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
    }
    func scrollToNearestVisibleCollectionViewCell() {
        suggestionCollection.decelerationRate = 0.1
        let visibleCenterPositionOfScrollView = Float(suggestionCollection.contentOffset.x + (self.suggestionCollection!.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<suggestionCollection.visibleCells.count {
            let cell = suggestionCollection.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = suggestionCollection.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.suggestionCollection!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func sideMenu(){
       if revealViewController() != nil{
            menuButton.target=revealViewController()
            menuButton.action=#selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=275
            revealViewController().rightViewRevealWidth=160
            
        }
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func customizeNav(){
        navigationController?.navigationBar.tintColor=UIColor(red: 52/255, green: 96/255, blue: 96/255, alpha: 1)
        navigationController?.navigationBar.barTintColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    
}
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


