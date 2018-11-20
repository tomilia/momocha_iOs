//
//  ResultController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 24/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
struct store_detail{
    
    let district: String!
    let lang: Int!
    let long: Int!
    let CHtitle: String!
    let CNtitle: String!
    let ENGtitle: String!
    let telephone: String!
    let full_address: String!
    
    init(json: JSON){
        CHtitle = json["CHtitle"].string
        CNtitle = json["CNtitle"].string
        ENGtitle = json["ENGtitle"].string
        district = json["district"].string
        lang = json["lang"].int
        long = json["long"].int
        telephone = json["telephone"].string
        full_address = json["full_address"].string
    }
}
struct cmx{
    let author: String?
    let content:String?
    let rating: Int?

}
protocol cmsegueDelegator {
    func callSegueFromCell(myData dataobject: AnyObject)
}
class ResultController: UIViewController, UITableViewDelegate, UITableViewDataSource,cmsegueDelegator {
    func callSegueFromCell(myData dataobject: AnyObject) {
        self.performSegue(withIdentifier: "moreCm", sender: dataobject)
    }
    
    
    
    struct StoryBoard{
        static let NameCell = "ShopNameCell"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var y = scrollView.contentOffset.y / 200
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }

        
       
        if y > 1
        {
            y = 1
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: y)
             self.navigationController?.navigationBar.tintColor = UIColor(red: 62/256, green: 96/256, blue: 96/256, alpha: y)
            statusBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: y)
 
            
           
            let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red: 62/256, green: 96/256, blue: 96/256, alpha: y)]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
             self.navigationItem.title = "泰舒適"
        }
        else{
            print("vue",UIColor.getHue(UIColor(red: 62/256, green: 96/256, blue: 96/256, alpha: y)))
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: y)
            var tempy = y
            if tempy == 0.0
            {
                 self.navigationController?.navigationBar.tintColor = UIColor(red: 256, green: 256, blue: 256, alpha: 1)
            }
            else{
             self.navigationController?.navigationBar.tintColor = UIColor(red: 62/256, green: 96/256, blue: 96/256, alpha: tempy)
            }
            self.navigationItem.title?.removeAll()
statusBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: y)
           let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red: 62/256, green: 96/256, blue: 96/256, alpha: y)]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            self.navigationItem.title = "泰舒適"
        }
       
        print("Y",y)
        
    }
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: []) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString) // <-- here is ur string
            
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
    
    func fetchData() throws {
var url = "http://59.148.36.170:8000/search0/result/"
            let headers = [
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Content-Type": "application/json"
            ]
        url += String(index!)
        
        Alamofire.request(url, headers: headers).responseJSON (completionHandler: { (response) in
                switch response.result{
                case .success(var value):
          
                        
                    let cv = JSON(value)
                    print("cx",String(describing: cv["cx"]))
                    if let dataFromString = String(describing: cv["cx"]).data(using: String.Encoding.utf8, allowLossyConversion: false) {
                       
                        var json :JSON
                        do{
                            json = try JSON(data: dataFromString)
                        }
                        catch let error as NSError {
                            json = JSON.null
                            print(error.localizedDescription)
                        }
                        print("checks",json[0]["fields"])
                        
                        // Check if the JSON is an array otherwise nil
                        
                        self.result_detail = store_detail(json: json[0]["fields"])
                        print("rdxc",self.result_detail)
                        self.main_table.reloadData()
                    }
                    if let cmString = String(describing: cv["cm"]).data(using: String.Encoding.utf8, allowLossyConversion: false) {
                        var json :JSON
                        do{
                            json = try JSON(data: cmString)
                        }
                        catch let error as NSError {
                            json = JSON.null
                            print(error.localizedDescription)
                        }
                        print("gelgod",json)
                      
                        for (key,subJson) in json {
                            if Int(key)! > 2
                            {
                                break
                            }
                            self.cm.append(cmx(author: subJson["user"].string, content: subJson["content"].string, rating: 5))
                           print("xox",subJson["content"])
                        }
                        self.main_table.reloadData()
                    
                    }
                case .failure(let error):
              
                    print(error.localizedDescription)
                }
            })
        
    }
    func convertToDictionary(text: String) -> NSArray? {
        if let data = text.data(using: .utf8) {
            do {
                let js = try JSONSerialization.jsonObject(with: data, options: [])
                return (js as! NSArray)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    override func viewDidAppear(_ animated: Bool) {
        
        main_table.reloadData() // reloading data for the first tableView serves another purpose, not exactly related to this question.
        main_table.setNeedsLayout()
        main_table.layoutIfNeeded()
        main_table.reloadData()
    }
    
    var info = ["67786054","南山區深南大道 9028-2號深圳益田威斯汀酒店 5180534","MON-FRI"]
    var cm = [cmx]()
    var service = ["","","","",""]
    var itemService = ["","","","","",""]
    var index :Int?

    var result_detail : store_detail?
    @IBOutlet weak var main_table: UITableView!
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)

        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        main_table.delegate = self
        main_table.dataSource = self
        main_table.separatorStyle = .none
        do{
            
            try fetchData()
        }
        catch{
            return
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
        return 2
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        }
        else {
            return 1
        }
    }

 /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.NameCell, for: indexPath) as! NameCell
        cell.name.text = "test"
        // Configure the cell...

        return cell
    }
 */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return section == 0 ? 0.1 : 2.0
    }
   /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
      
        if indexPath.section == 0
        {
            switch indexPath.row {
            case 0:     // header cell
                return 220
            default:
                return 60
            }
    
        }
        else if indexPath.section == 1
        {

            return CGFloat(42 * info.count)

        }
        else{
            print("auto:",UITableViewAutomaticDimension)
           return UITableViewAutomaticDimension
        }
        return UITableViewAutomaticDimension
    }*/
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
  
                //设置estimatedRowHeight属性默认值
                //rowHeight属性设置为UITableViewAutomaticDimension
            if indexPath.section == 0
            {
                if indexPath.row == 0
                {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollCell")
                    as! ScrollCell
                    cell.frame = tableView.bounds
                    cell.layoutIfNeeded()
                     main_table.rowHeight = 200
                //重新加载单元格数据

                return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell")
                        as! nameCellTableViewCell
                    cell.frame = tableView.bounds
                    cell.layoutIfNeeded()
                    cell.name.text = result_detail?.CHtitle
                     main_table.rowHeight = 70
                    return cell
                }
                
            }
            else if indexPath.section == 1
            {
     
                var cell = tableView.dequeueReusableCell(withIdentifier: "infoCell")
                    as? InfoTableViewCell
                if cell == nil {
             
                cell = InfoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "infoCell")
                }
                
                var dataArr :[String?] = []
                cell?.frame = tableView.bounds
                cell?.layoutIfNeeded()
                print(result_detail?.telephone,result_detail?.full_address,result_detail?.ENGtitle)
                dataArr = [result_detail?.telephone,result_detail?.full_address,result_detail?.ENGtitle]
                cell?.updateData(data: dataArr)
                main_table.rowHeight = (cell?.tableViewHeight())!
                 print("rdc",cell?.dataArr)
                return cell!
                
      
            
            }else if indexPath.section == 2{
                
                tableView.register(UINib(nibName:"ServiceTableViewCell", bundle:nil),
                                         forCellReuseIdentifier:"serviceCell")
                //设置estimatedRowHeight属性默认值
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell")
                    as! ServiceTableViewCell
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                print("xtx:",cell.calculateWidth())
                
                //重新加载单元格数据
                main_table.rowHeight = cell.calculateWidth() * ceil(CGFloat(service.count) / 3.0)  + CGFloat(cell.cellMarginSize) + 30 + cell.m_title.bounds.height
                cell.reloadData()
                return cell
            }
            else if indexPath.section == 3{
                tableView.register(UINib(nibName:"ItemServiceTableViewCell", bundle:nil),
                                   forCellReuseIdentifier:"itemserviceCell")
                //设置estimatedRowHeight属性默认值
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "itemserviceCell")
                    as! ItemServiceTableViewCell
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                print("xtx:",cell.calculateWidth())
                
                //重新加载单元格数据
                main_table.rowHeight = 80 * CGFloat(itemService.count) + 10 * CGFloat(itemService.count ) + 10 * 1.5 + 30 + cell.title.frame.height
                
                cell.reloadData()
                return cell
            }
            else
            {
                tableView.register(UINib(nibName:"CommentTableViewCell", bundle:nil),
                                   forCellReuseIdentifier:"commentCell")
                let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell")
                    as! CommentTableViewCell
                print("tbb",tableView.bounds.width)
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
               cell.delegate = self
                cell.cmArr = cm
                cell.reloaddata()
                //重新加载单元格数据
               
                
                main_table.rowHeight = cell.tableViewHeight()
     
                return cell
            }
            
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class UIDynamicTableView: UITableView
{
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: self.contentSize.height)
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
} 
