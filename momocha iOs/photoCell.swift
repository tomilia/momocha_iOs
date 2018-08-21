//
//  photoimage.swift
//  momocha iOs
//
//  Created by Tommy Lee on 9/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
var imageCache =  NSCache<AnyObject, AnyObject>()
class photoCell: UICollectionViewCell {
    var cata: Cata?{
        didSet{
            image.image = nil
            if let bgimg = cata?.imageLink{
                if let image_x = imageCache.object(forKey: bgimg as AnyObject){
                    image.image = image_x as! UIImage
                }
                else
                {
                URLSession.shared.dataTask(with: URL(string: bgimg)!, completionHandler: { (data, response, error) in
                    if error != nil{
                        print(error)
                        return
                    }
                    let image = UIImage(data: data!)
                    imageCache.setObject(image!, forKey: bgimg as AnyObject)
                    DispatchQueue.main.async() {
                       self.image.image=image
                    }
                    
                }).resume()
                }
              
            }
            if let name = cata?.title{
                print(name)
                name_x.text = name
                name_x.sizeToFit()
                
            }
            
        }
    }
    @IBOutlet weak var bliur: UIVisualEffectView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name_x: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
}
