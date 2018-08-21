//
//  hotSearch.swift
//  momocha iOs
//
//  Created by Tommy Lee on 10/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class hotSearch: UICollectionViewCell {
    var hottag: Hottag?{
        didSet{
            image.image = nil
            if let bgimg = hottag?.imageLink{
                if let image_x = imageCache.object(forKey: bgimg as AnyObject){
                    image.image = image_x as? UIImage
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
            if let name = hottag?.title{
                print(name)
                    title.text = name
                title.sizeToFit()
                
            }
        }
    }
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    }

