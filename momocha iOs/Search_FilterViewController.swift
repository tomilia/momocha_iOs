//
//  Search_FilterViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 17/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//
import UIKit
protocol Search_FilterViewControllerDelegate: class {
    func removeBlurredBackgroundView()
    func showNav()
    func requestByQuery()
}

//每月书籍
struct BookPreview {
    var title:String
    var names:[String]
    var images:[UIImage]?
}

class Search_FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,CustomCellDelegate,locationSelectionDelegate {
    var tempQuery = [String : String]()
    func returnLocation(sc: [String]) {
        let transformed_sc = sc.joined(separator: ",")
        tempQuery["district"] = transformed_sc
    }
    
    func cellButtonTapped(sc: [Int]) {
        
        let transformed_sc = sc.map(String.init).joined(separator: ",")
        tempQuery["additional_service"] = transformed_sc
    }
    func putTempQuerytoCurrentQ(){
        queryResult["district"] = tempQuery["district"]
        queryResult["additional_service"] = tempQuery["additional_service"]
    }
    var locationSelect = [String]()
    @IBOutlet weak var submit: UIButton!
    @IBAction func submitAct(_ sender: Any) {
        putTempQuerytoCurrentQ()
        delegate?.requestByQuery()
        backToResult()
    }
    
    @IBAction func cancel(_ sender: Any) {
        tempQuery.removeAll()
       backToResult()
    }
    func backToResult(){
        self.view.isHidden = true
        dismiss(animated: true, completion: nil)
        
        delegate?.removeBlurredBackgroundView()
        delegate?.showNav()
    }
    weak var delegate: Search_FilterViewControllerDelegate?
    //所有书籍数据
    let books = [
        BookPreview(title: "地區🤧",names:["羅湖區","老街區","？？區","!!區","xx區"],images:nil),
        BookPreview(title: "地鐵站👿",names:["羅湖站","老街站","？？站"],images:nil),
        BookPreview(title: "附加服務😮",names:["wifi","乒乓球","yea","yea","yea","yea","yea"],images:[#imageLiteral(resourceName: "home-s1x"),#imageLiteral(resourceName: "magnifying1x"),#imageLiteral(resourceName: "heart1x"),#imageLiteral(resourceName: "heart1x"),#imageLiteral(resourceName: "heart1x"),#imageLiteral(resourceName: "heart1x"),#imageLiteral(resourceName: "heart1x")])
    ]
    
    //显示内容的tableView
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置tableView代理
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        resetQuery()
        //去除单元格分隔线
        self.tableView!.separatorStyle = .none
        roundtheButton()
        //创建一个重用的单元格

    }
    func resetQuery(){
        queryResult["additional_service"]?.removeAll()
        queryResult["district"]?.removeAll()
    }
    func roundtheButton(){
        self.submit.layer.cornerRadius = 10
        self.submit.clipsToBounds = true
    }
    //在本例中，只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
         
            if indexPath[1] == 2
                
            {
                self.tableView!.register(UINib(nibName:"tableimageViewCell", bundle:nil),forCellReuseIdentifier:"tableimageCell")
                print("tablex",self.tableView)
                //设置estimatedRowHeight属性默认值

                let cell = tableView.dequeueReusableCell(withIdentifier: "tableimageCell")
                    as! filter_cell_image_TableViewCell
                cell.delegate = self
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
   
                //重新加载单元格数据
                cell.reloadData(title:books[indexPath.row].title,names:books[indexPath.row].names,images: books[indexPath.row].images!)
                return cell
                
            }
            else
            {
                self.tableView!.register(UINib(nibName:"tableViewCell", bundle:nil),
                                         forCellReuseIdentifier:"tableCell")
                print("tablex",self.tableView)
                //设置estimatedRowHeight属性默认值

                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
                as! filter_cell_TableViewCell
                cell.delegate = self
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                //重新加载单元格数据
                cell.reloadData(title:books[indexPath.row].title,names:books[indexPath.row].names)
                return cell
            }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
