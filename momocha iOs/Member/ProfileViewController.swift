//
//  ProfileViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 14/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//
import Alamofire
import SwiftyJSON
import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBOutlet weak var user_image: UIImageView!
    
    @IBOutlet weak var setting: UIButton!
    
    @IBOutlet weak var profileview: UIView!
    let estimateWidth = 50.0
    let cellMarginSize = 10.0
    
    let books = [
        BookPreview(title: "地區🤧",names:["羅湖區","老街區","？？區","!!區","xx區"],images:nil),
        BookPreview(title: "地鐵站👿",names:["羅湖站","老街站","？？站"],images:nil),
        BookPreview(title: "附加服務😮",names:["我的訂單","最近瀏覽","積分詳情","升級會員"],images:[#imageLiteral(resourceName: "order3x"),#imageLiteral(resourceName: "clock3x"),#imageLiteral(resourceName: "diamond1x"),#imageLiteral(resourceName: "cancel1x")])
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var m_money: UILabel!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       /* if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileInfo")
                as! ProfileInfoTableViewCell
            print("cell",cell)
        
        cell.username.text = "jsdfvms"
        cell.m_cash.text = "$200"
            tableView.rowHeight = 200
            cell.frame = tableView.bounds
            
            cell.layoutIfNeeded()

            return cell
        }
        else */
        /*
        if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "extrafunc")
                    as! ExtraFuncTableViewCell
                print("cell",cell)
            cell.reloadData(title:books[2].title,names:books[2].names,images: books[2].images!)
                tableView.rowHeight = 100
            
                cell.frame = tableView.bounds
            
                cell.layoutIfNeeded()

                return cell
            }
        else {*/
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "extraoptions")
                as! MemberOptionsTableViewCell
            print("cellxxx ",cell)
    
            cell.frame = tableView.bounds
            
            cell.layoutIfNeeded()
            tableView.rowHeight = cell.tableViewHeight()+20
            return cell
        
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
 
    @IBOutlet var main_view: UIView!
    
    var delegate: LoginSwitchDelegator?
    
    @IBOutlet weak var usertable: UITableView!
    @IBOutlet weak var username: UILabel!
    
    @IBAction func logout(_ sender: Any) {
        logoutFunc(sessionExpired: false)
        /*
         
        self.navigationController?.popViewController(animated: true)
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? MemberNoLoginViewController {
           print(self.navigationController?.viewControllers)
            self.navigationController?.pushViewController(viewController, animated: true)
             print(self.navigationController?.viewControllers)
        }
 
        print(delegate)
        let sVC = switchViewController()
        //self.delegate = sVC
       // delegate?.login_switch_view()
        */
    }
    func logoutFunc(sessionExpired: Bool){
        UserDefaults.standard.removeObject(forKey: "session")
        UserDefaults.standard.synchronize()
        var url = "http://59.148.36.170:8000/account_logout"
        let headers = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/json"
        ]
        Alamofire.request(url, headers: headers).responseJSON (completionHandler: { (response) in
            switch response.result{
            case .success(var value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        /*
         if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? MemberNoLoginViewController {
         self.navigationController?.pushViewController(viewController, animated: true)
         
         }
         */print(self.navigationController?.viewControllers)
        /*
         let sVC = switchViewController()
         self.delegate = sVC
         delegate?.login_switch_view()
         */
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? MemberNoLoginViewController {
            print("oko")
            if let navigator = self.navigationController {
                navigator.setViewControllers([viewController], animated: true)
                if sessionExpired
                {
                let alert = UIAlertController(title: "登入逾期", message: "請重新登入", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK!", style: .default) { (UIAlertAction) in
                    
                    self.nothing()
                    
                }
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    func nothing(){
        
    }
    var mx: member?
    func get_login(){
        var url = "http://59.148.36.170:8000/test/"
        let headers = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/json"
        ]
                Alamofire.request(url, headers: headers).responseJSON (completionHandler: { (response) in
                    switch response.result{
                    case .success(var value):
                        let cx = JSON(value)
                        if cx["lgin"].bool!
                        {
    
                        self.mx = member(json: cx)
                            self.loadUser()
                        }
                        else
                        {
                     
                         
                            self.logoutFunc(sessionExpired: true)
                        }
                        print(self.mx)
                        
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
        })
    }
    func loadUser(){
        if mx?.first_name != ""
        {
            user_name.text = "你好! "+(mx?.first_name)!
        }
        else if mx?.username != ""
        {
            user_name.text = "你好! "+(mx?.username)!
        }
        else if mx?.phone_num != ""
        {
            user_name.text = "你好! "+(mx?.phone_num)!
        }
        else
        {
            user_name.text = "你好! "+(mx?.email)!
        }
    }
    @IBOutlet weak var session_x: UILabel!
    @IBOutlet weak var logout: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        usertable.delegate = self
        usertable.dataSource = self
        usertable.separatorStyle = .none
        collectionView!.register(UINib(nibName:"ItemService", bundle:nil),forCellWithReuseIdentifier: "extra_item_service")
        collectionView.layer.cornerRadius = 10.0
        collectionView.layer.masksToBounds = true
        collectionView.layer.shadowColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView.layer.shadowRadius = 2.0
        collectionView.layer.shadowOpacity = 1.0
        collectionView.layer.masksToBounds = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        user_image.layer.cornerRadius = user_image.frame.height/2.0
        user_image.clipsToBounds = true
        user_image.layer.borderColor = UIColor.lightGray.cgColor
        user_image.layer.borderWidth = 2
        //user_name.text = "KEPKPCWE"
        //m_money.text = "$2000"
        setting.titleLabel?.minimumScaleFactor = 0.5
        setting.titleLabel?.numberOfLines = 1
        setting.titleLabel?.adjustsFontSizeToFitWidth = true
        let layer = CAGradientLayer()
        layer.colors = [UIColor(red: 2/255, green: 170/255, blue: 176/255, alpha: 1.0).cgColor,UIColor(red: 0/255, green: 205/255, blue: 172/255, alpha: 1.0).cgColor]
        layer.locations = [0.0,0.35]
        layer.frame = CGRect(x:0, y:0, width:view.bounds.width, height:profileview.frame.height + (UIApplication.shared.statusBarView?.frame.height)!+(collectionView.frame.height/2))
        self.view.layer.insertSublayer(layer, at: 0)
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        //session_x.text = UserDefaults.standard.string(forKey: "session")
        //session_x.sizeToFit()
        get_login()
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

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension ProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "extra_item_service",for: indexPath) as! ExtraFuncCollectionViewCell
        cell.m_label.text = books[2].names[indexPath.item]
        cell.m_image.image = books[2].images?[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,  numberOfItemsInSection section: Int) -> Int{
        return books[2].names.count
    }
    
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.calculateWidth()
        return CGSize(width: width,height:90)
    }
    func calculateWidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount:CGFloat = 4.0
        print("cell count",cellCount*estimatedWidth+((cellCount+1) * CGFloat(cellMarginSize)))
        
        let margin = CGFloat(cellMarginSize)
        let width = (self.collectionView.frame.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        print("width:",width)
        return width
    }
}
extension UICollectionView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }}
