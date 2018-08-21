//
//  HotFragViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 9/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
let historyCache = NSCache<NSString, NSString>()
class HotFragViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let cellIdentifier = "hotSearchIdentifier"
    let cellIdentifier2 = "preferences"
    var hottag=[Hottag]()
     @IBOutlet weak var hotViewCollection: UICollectionView!
    @IBOutlet weak var recordCollection: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotViewCollection
        {
            print("yeahx")
            return 3
        }
        else{
            print("yeahy")
            return myarray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == hotViewCollection
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotSearchIdentifier", for: indexPath) as! hotSearch
            cell.hottag=hottag[indexPath.item]
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            return cell
        }
        else
        {
                    print("check")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "preferences", for: indexPath) as! preferences
            cell.title.text = myarray[indexPath.item]
            cell.title.sizeToFit()
            return cell
        }
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()

        hotViewCollection.register(UINib(nibName: "hotSearch", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        hotViewCollection.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let HotA = Hottag()
        HotA.title = "中式"
        HotA.imageLink = "https://i.imgur.com/Eikjcqt.jpg"
        let HotB = Hottag()
        HotB.title = "泰式"
        HotB.imageLink = "https://i.imgur.com/OCRYWOF.jpg"
        let HotC = Hottag()
        HotC.title = "熱石"
        HotC.imageLink = "https://i.imgur.com/sel5uDz.jpg"
        hottag.append(HotA)
        hottag.append(HotB)
        hottag.append(HotC)
        recordCollection.register(UINib(nibName: "preferences", bundle: nil), forCellWithReuseIdentifier: cellIdentifier2)
        hotViewCollection.delegate = self as UICollectionViewDelegate

        recordCollection.delegate = self as UICollectionViewDelegate
        hotViewCollection.dataSource = self as UICollectionViewDataSource
        recordCollection.dataSource = self as UICollectionViewDataSource

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
