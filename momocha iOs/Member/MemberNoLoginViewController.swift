//
//  MemberViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 9/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//
import Alamofire
import SwiftyJSON
import UIKit
class NXTextField: UITextField{
    var inset:UIEdgeInsets = UIEdgeInsets(top: -5, left: 2, bottom: 5, right: 0)
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, inset)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, inset)
    }
}
class MemberNoLoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
 
    @IBAction func login(_ sender: Any) {
        do{
            try self.fetchData(username: self.username.text!, password:self.password.text! )
        }
        catch{
            print("kdowkf")
        }
    }
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var banner: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        banner.adjustsFontSizeToFitWidth=true
        banner.minimumScaleFactor=0.5
        
        username.inputAccessoryView = toolbar
        password.inputAccessoryView = toolbar
        
        username.layer.borderWidth = 1.0
        password.layer.borderWidth = 1.0
        username.layer.cornerRadius = 5.0
        password.layer.cornerRadius = 5.0
        let myColor = UIColor.lightGray
        username.layer.borderColor = myColor.cgColor
        password.layer.borderColor = myColor.cgColor
        /*
        self.addLineToView(view: username, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 88/256, green: 172/256, blue: 171/256, alpha: 1), width: 1)
        self.addLineToView(view: password, position:.LINE_POSITION_BOTTOM, color: UIColor.darkGray, width: 1)*/
        password.isSecureTextEntry = true
        
        // Do any additional setup after loading the view.
    }
    @objc func doneClicked(){
        view.endEditing(true)
    }
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    func loginRequest(){
      
        let headers = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/json"
        ]

        
        print(headers)
        Alamofire.request("http://192.168.0.101:8000/login/", method: .post, parameters: ["username":"koeax@gmail.com","password":"a25480097"], encoding: JSONEncoding.default, headers: headers).responseJSON
            { (response:DataResponse) in
                switch(response.result)
                {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                    break
                }
                
        }
     
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        default:
            break
        }
    }
    func fetchData(username: String, password: String) throws {
        let alert_x = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert_x.view.addSubview(loadingIndicator)
        present(alert_x, animated: true, completion: nil)
        var url = "http://59.148.36.170:8000/m_login/"
        let headers = [
            "Authorization": "token QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        let parameters : Parameters = ["username":username,"password":password]
 Alamofire.request(url,method: .post,parameters:parameters, headers: headers).responseJSON (completionHandler: { (response) in
            switch response.result{
                
            case .success(var value):
                let cv = JSON(value)
                print(cv)
                
                self.dismiss(animated: true, completion: {
                    if cv["session"] != nil
                    {
                        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
                            
                            if let navigator = self.navigationController {
                              navigator.setViewControllers([viewController], animated: true) 
                            }
                        }
                        UserDefaults.standard.set(cv["session"].string, forKey: "session")
                        UserDefaults.standard.synchronize()
                        print(UserDefaults.standard.string(forKey: "session"))
                    }
                    else{
                        let alert = UIAlertController(title: "密碼no", message: "", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK!", style: .default) { (UIAlertAction) in
                            
                            self.nothing()
                            
                        }
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: {
                           
                        
                        })
                    }
 
            
                    
                })

            case .failure(let error):
                alert_x.dismiss(animated: true, completion: nil)
                print(error.localizedDescription)
            }
    
        })
 
        
    }
    func nothing(){
        
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
