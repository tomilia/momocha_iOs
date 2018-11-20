//
//  MainTabbViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 27/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class MainTabbViewController: UITabBarController,UITabBarControllerDelegate {
    var tapCounter : Int = 0
    var previousVC = UIViewController()
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("hjso")
        self.tapCounter += 1
        let hasTappedTwice = self.previousVC == viewController
        self.previousVC = viewController
        print("tapc",tapCounter)
        if self.tapCounter == 2 && hasTappedTwice {
            self.tapCounter = 0
            print ("Double Tapped!")
        }
        if self.tapCounter == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tapCounter = 0
            }
          
        }
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ha")
        self.delegate = self
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
