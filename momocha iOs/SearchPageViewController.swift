//
//  SearchPageViewController.swift
//  momocha iOs
//
//  Created by Tommy Lee on 9/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
// dict is of type Dictionary<Int, String>
let userDefaults = UserDefaults.standard
 var myarray = userDefaults.stringArray(forKey: "SavedStringArray") ?? [String]()
class SearchPageViewController: UIViewController,UISearchBarDelegate,UICollectionViewDelegateFlowLayout{


var key = "saved"
    @IBOutlet weak var topLabel: EdgeInset!
    @IBOutlet weak var scrollFrag: UIView!
    @IBOutlet weak var hotFrag: UIView!
    @IBOutlet weak var viewController1: HotFragViewController!
    @IBOutlet weak var SearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.numberOfLines = 0
        topLabel.sizeToFit()
        SearchBar.delegate = self
        SearchBar.setValue("取消", forKey: "_cancelButtonText")
        // Do any additional setup after loading the view.
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("searchText \(searchText)")
        // Do some search stuff
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
       searchBar.showsCancelButton = true
       changeFrags(frags: 0)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        changeFrags(frags: 1)
        // You could also change the position, frame etc of the searchBar
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "hotSearchId" {
            if let viewController1 = segue.destination as? HotFragViewController {
                self.viewController1 = viewController1
                
            }
                }
            else if segue.identifier == "testId"{
                let nviewController2 = segue.destination as? UINavigationController
                let vc = nviewController2?.viewControllers.first as! SearchResult
                    vc.search_query = SearchBar.text!
            
            }
    }
    func changeFrags(frags :Int){
        if frags == 0
        {
            UIView.animate(withDuration:0.1, animations: {
                self.scrollFrag.alpha = 1
                self.hotFrag.alpha = 0
            })
        }
        else{
            UIView.animate(withDuration:0.1, animations: {
                self.hotFrag.alpha = 1
                self.scrollFrag.alpha = 0
            })
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        myarray.append(searchBar.text!)
        print("hello",myarray)
        userDefaults.set(myarray, forKey: "SavedStringArray")
        userDefaults.synchronize()
        let stringRepresentation = myarray.description //

        viewController1!.recordCollection.reloadData()
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchResult") ; // MySecondSecreen the storyboard ID
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil);
 */
        performSegue(withIdentifier: "testId", sender: self)
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
