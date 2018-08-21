//
//  photoFragViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 9/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit


class photoFragViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var isCollectionViewScrollUp: Bool = true
    let cellIdentifier = "photoCell"
    
    let suggestion1=["CHtitle":"中式按摩"]
    let suggestion2=["CHtitle":"泰式按摩"]
    let suggestion3=["CHtitle":"推油按摩"]
    let suggestion4=["CHtitle":"按摩"]
    let suggestion5=["CHtitle":"按摩"]
    let suggestion6=["CHtitle":"按摩"]
    var imageArray=[UIImage]()
    var cata=[Cata]()
    var photoXArray=[Dictionary<String,String>]()
    @IBOutlet weak var photoCatCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cata.count
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCell
      //animation start
        let collectionHeight: CGFloat = collectionView.bounds.size.height
        
        let contentOffsetY: CGFloat = collectionView.contentOffset.y
        let contentSizeHeight: CGFloat = collectionView.contentSize.height
        
        var height:CGFloat = 0.0//collectionHeight * CGFloat(indexPath.row)
        print(collectionView.frame.size.height + contentOffsetY,contentSizeHeight)
        if isCollectionViewScrollUp && (contentOffsetY + collectionView.frame.size.height) < contentSizeHeight {
            
            let index = Int(indexPath.row) + Int(1)
            if index % 3 == 1 {
                height = collectionHeight + 300
            }
            else if index % 3 == 2 {
                height = collectionHeight + 300 * 2
            }
            else {
                height = collectionHeight + 300 * 3
            }
            
            cell.transform = CGAffineTransform(translationX: 0, y: height)
            print("disdpc")
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0);
        }, completion: nil)
        //animation end
        cell.cata=cata[indexPath.item]
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds,cornerRadius:cell.contentView.layer.cornerRadius).cgPath

        cell.bliur.frame = CGRect(x: 0,y: 0,width: view.frame.width,height: view.frame.height)
        cell.bliur.alpha = 0.2
        print("ia",self.imageArray.count)
 
          return cell
    }
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let scrollVelocity:CGPoint  = self.photoCatCollection.panGestureRecognizer.velocity(in: self.photoCatCollection?.superview)
            if scrollVelocity.y > 0.0 { //ScrollDown

                isCollectionViewScrollUp = false
            } else if scrollVelocity.y < 0.0 { //ScrollUp
                isCollectionViewScrollUp = true
            }
        }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let memoryCap = 500*1024*1024
        let diskCap = 500*1024*1024
        let urlCache = URLCache(memoryCapacity: memoryCap, diskCapacity: diskCap, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        let CataA = Cata()
        CataA.title = "中式按摩"
        CataA.imageLink = "https://i.imgur.com/Eikjcqt.jpg"
        
        let CataB = Cata()
        CataB.title = "泰式按摩"
        CataB.imageLink = "https://i.imgur.com/OCRYWOF.jpg"
        let CataC = Cata()
        CataC.title = "熱石"
        CataC.imageLink = "https://i.imgur.com/sel5uDz.jpg"
        let CataD = Cata()
        CataD.title = "on99"
        CataD.imageLink = "https://i.imgur.com/7mJkHBD.jpg"
        let CataE = Cata()
        CataE.title = "on999"
        CataE.imageLink = "https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/N_-wj6-wx/videoblocks-blur-background-light-bokeh-of-night-festival-bulbs-and-colorful-flags-at-blue-sky-magic-hour_hbvt4ohew_thumbnail-full01.png"
        let CataF = Cata()
        CataF.title = "on999"
        CataF.imageLink = "https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/N_-wj6-wx/videoblocks-blur-background-light-bokeh-of-night-festival-bulbs-and-colorful-flags-at-blue-sky-magic-hour_hbvt4ohew_thumbnail-full01.png"
        cata.append(CataA)
        cata.append(CataB)
        cata.append(CataC)
        cata.append(CataD)
        cata.append(CataE)
        cata.append(CataF)
        photoXArray=[suggestion1,suggestion2,suggestion3,suggestion4,suggestion5,suggestion6]
        photoCatCollection.register(UINib(nibName: "photoCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        photoCatCollection.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

            
        
        
        photoCatCollection.delegate = self
        photoCatCollection.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
