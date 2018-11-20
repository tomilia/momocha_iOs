//
//  FavouriteViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 6/10/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    @IBOutlet weak var favourite_table: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil),forCellReuseIdentifier: "favouritecell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouritecell")
    
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        favourite_table.delegate = self
        favourite_table.dataSource = self
        
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
