//
//  SearchResult.swift
//  momocha iOs
//
//  Created by Tommy Lee on 10/8/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit
import Segmentio

enum CustomError: Error {
    case error01
}
enum SegmentioPosition {
    case dynamic
    case fixed(maxVisibleItems: Int)
}
struct result{
    
    let id: Int?
    let CHtitle: String?
    let ENGTitle: String?
    var segmentio: Segmentio!
    init(json: [String: Any]){
        id = json["i_id"] as? Int ?? -1
        CHtitle = json["CHtitle"] as? String ?? ""
        ENGTitle = json["ENGtitle"] as? String ?? ""
    }
}

class SearchResult: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,Search_FilterViewControllerDelegate {
    @IBOutlet weak var loading: UIView!
    let cellIdentifier = "resultCellIdentifier"
    @IBOutlet weak var resultCollection: UICollectionView!
    
    @IBOutlet weak var segmentioView: Segmentio!
   
    @IBAction func openFilter(_ sender: Any) {
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        self.overlayBlurredBackgroundView()
    }
    var result_show = [result]()
    @IBOutlet weak var tetsi: UILabel!
    var search_query = String()
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("json:",result_show.count)
        return result_show.count
    }
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .light)
        blurredBackgroundView.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 0.9)
        view.addSubview(blurredBackgroundView)
        
    }
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCellIdentifier", for: indexPath) as! resultCell
        print("reloading!")
        cell.m_title.text = result_show[indexPath.item].CHtitle
        
        cell.m_title.sizeToFit()
        cell.m_image.layer.cornerRadius = 5.0
        cell.m_image.layer.borderWidth = 1.0
        cell.m_image.layer.borderColor = UIColor.clear.cgColor
        cell.m_image.layer.masksToBounds = true
        print(search_query)
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0,y: cell.frame.height-0.5,width: cell.frame.width,height: 0.5)
        
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.bounds = bottomLine.frame.insetBy(dx: 10.0, dy: 0.0)
        cell.layer.addSublayer(bottomLine)
        return cell
    }
    let sortTab: SortTab = {
        let sb = SortTab()
        return sb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load:",search_query)
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchResult.back(sender:)))
        setupToolbar()
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
        newBackButton.tintColor = UIColor.brown
        self.navigationItem.leftBarButtonItem =  newBackButton
        
           resultCollection.register(UINib(nibName: "resultCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        resultCollection.delegate = self as UICollectionViewDelegate
        resultCollection.dataSource = self as UICollectionViewDataSource
        print("reloadx:",self.result_show.count)
        
        
    }
    func showNav() {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("yespk",segue)
        if let identifier = segue.identifier {
            
            if identifier == "ShowModal" {
                if let viewController = segue.destination as? Search_FilterViewController {
                    
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                    self.navigationController?.navigationBar.isHidden = true
                }
            }
        }
    }
    private func setupToolbar(){
        var content = [SegmentioItem]()
        
        let tornadoItem = SegmentioItem(
            title: "🤣默認排序",
            image: #imageLiteral(resourceName: "user1x")
        )
        let soldadoItem = SegmentioItem(
            title: "😏時間排序",
            image: #imageLiteral(resourceName: "home-s1x")
        )
        let mornadoItem = SegmentioItem(
            title: "🤯人氣排序",
            image: #imageLiteral(resourceName: "home-s1x")
        )

        var indicator = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 2,
            color: UIColor(red: 52/255, green: 96/255, blue: 96/255, alpha: 255/255)
        )
        var topbotborder = SegmentioHorizontalSeparatorOptions(
            type: SegmentioHorizontalSeparatorType.bottom, // Top, Bottom, TopAndBottom
            height: 0.4,
            color: UIColor.lightGray
        )
        var verticalsep = SegmentioVerticalSeparatorOptions(
            ratio: 0, // from 0.1 to 1
            color: UIColor.lightGray
        )
        var state = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 16),
                titleTextColor: UIColor.lightGray
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 16),
                titleTextColor: UIColor(red: 60/255, green: 96/255, blue: 96/255, alpha: 1.0)
                
            ),
            highlightedState: SegmentioState(
                backgroundColor: UIColor.lightGray.withAlphaComponent(0.2),
                titleFont: UIFont.systemFont(ofSize: 16),
                titleTextColor: UIColor(red: 60/255, green: 96/255, blue: 96/255, alpha: 1.0)
            )
        )
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            self.sortChange(segmentIndex: segmentIndex)
        }
        segmentioView.setup(
            content: [tornadoItem,soldadoItem,mornadoItem],
            style: .onlyLabel,
            options: SegmentioOptions(
                backgroundColor: .white,
                scrollEnabled: true,
                indicatorOptions: indicator,
                horizontalSeparatorOptions: topbotborder, verticalSeparatorOptions: verticalsep,
                imageContentMode: .center,
                labelTextAlignment: .center,
                segmentStates: state
            )
        )
        segmentioView.selectedSegmentioIndex = 0
    }
    func sortChange(segmentIndex: Int)
    {
        if segmentIndex == 0
        {
            self.performSearch(str: self.search_query,sort: "default")
        }
        else if segmentIndex == 1{
            self.performSearch(str: self.search_query,sort: "price")
        }
        else
        {
            self.performSearch(str: self.search_query,sort: "popular")
        }
        
    }
    func convertToDictionary(text: String) -> NSArray? {
        if let data = text.data(using: .utf8) {
            print(data)
            do {
                 let js = try JSONSerialization.jsonObject(with: data, options: [])
                return (js as! NSArray)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func addContraintsWithFormat(_ format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    func performSearch(str: String,sort: String)
    {
 
        
        self.loading.isHidden = false
        let url = NSURL(string: "http://59.148.36.170:8000/filter/?q=&page=1&sort="+sort)
        print(sort)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            
            guard let jsonObj = (try!
                JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions())) as? [String: Any]
                else {
                    return
                   }
            print(jsonObj)
            if let temp = self.convertToDictionary(text: jsonObj["numpost"] as! String)
            {
                self.result_show.removeAll()
                for tp in temp
                {
                    
                    var tpx=(tp as! [String:Any])
                    self.result_show.append(result(json: tpx)
                    )
                }
                 DispatchQueue.main.async() {
                if self.result_show.count > 0{
                    
                    print("fuck",self.result_show.count)
                    self.resultCollection.reloadData()
                    self.loading.isHidden = true
                    self.resultCollection?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: true)
                }
                }
                
            }
            /*if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
             
                //printing the json in console
                print(jsonObj!.value(forKey: "avengers")!)
                
                //getting the avengers tag array from json and converting it to NSArray
                if let heroeArray = jsonObj!.value(forKey: "avengers") as? NSArray {
                    //looping through all the elements
                    for heroe in heroeArray{
                        
                        //converting the element to a dictionary
                        if let heroeDict = heroe as? NSDictionary {
                            
                            //getting the name from the dictionary
                            if let name = heroeDict.value(forKey: "name") {
                                
                                //adding the name to the array
                                self.nameArray.append((name as? String)!)
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    self.showNames()
                })
            }
            */
        }).resume()
    }
    @objc func back(sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

@IBDesignable
class DoubleImageButton: UIButton {
    /* Inspectable properties, once modified resets attributed title of the button */
    @IBInspectable var leftImg: UIImage? = nil {
        didSet {
            /* reset title */
            setAttributedTitle()
        }
    }
    
    @IBInspectable var rightImg: UIImage? = nil {
        didSet {
            /* reset title */
            setAttributedTitle()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setAttributedTitle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributedTitle()
    }
    
    private func setAttributedTitle() {
        var attributedTitle = NSMutableAttributedString()
        
        /* Attaching first image */
        if let leftImg = leftImg {
            let leftAttachment = NSTextAttachment(data: nil, ofType: nil)
            leftAttachment.image = leftImg
            let attributedString = NSAttributedString(attachment: leftAttachment)
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            
            if let title = self.currentTitle {
                mutableAttributedString.append(NSAttributedString(string: title))
            }
            attributedTitle = mutableAttributedString
        }
        
        /* Attaching second image */
        if let rightImg = rightImg {
            let leftAttachment = NSTextAttachment(data: nil, ofType: nil)
            leftAttachment.image = rightImg
            let attributedString = NSAttributedString(attachment: leftAttachment)
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            attributedTitle.append(mutableAttributedString)
        }
        
        /* Finally, lets have that two-imaged button! */
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.red.cgColor
            } else {
                self.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
}
extension UILabel{
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
