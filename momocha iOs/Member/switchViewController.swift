//
//  switchViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 14/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
protocol LoginSwitchDelegator {
    func login_switch_view()
}
class switchViewController: UINavigationController,LoginSwitchDelegator,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        print("log",isLoggedIn())
        login_switch_view()
        // Do any additional setup after loading the view.
    }
    func login_switch_view(){
        print("vcx",self.viewControllers.count)
       
        print("jvsod",UserDefaults.standard.string(forKey: "session"))
        if UserDefaults.standard.string(forKey: "session") != nil{
            popViewController(animated: true)
            
            let viewC = ProfileViewController()
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
                pushViewController(viewController, animated: true)
                
            }
          print("vkdso",self.viewControllers.first)
        }
        else{
          
             popViewController(animated: true)
            let viewC = MemberNoLoginViewController()
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? MemberNoLoginViewController {
                pushViewController(viewController, animated: true)
               
            }
   print("vkdso",self.viewControllers.first)
        }
        print("vcx",self.viewControllers)
    }
    @objc func showLoginPromptController(){
        let loginVC = MemberNoLoginViewController()
        present(loginVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func isLoggedIn() -> Bool{
        print("alcacer:",UserDefaults.standard.bool(forKey: "session"))
        return (UserDefaults.standard.string(forKey: "session") != nil)
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
