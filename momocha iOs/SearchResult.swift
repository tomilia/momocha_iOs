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
    
    let idx_id: Int?
    let id: Int?
    let CHtitle: String?
    let ENGTitle: String?
    var segmentio: Segmentio!
    init(json: [String: Any]){
        idx_id = json["i_id"] as? Int ?? -1
        id = json["id"] as? Int ?? -1
        CHtitle = json["CHtitle"] as? String ?? ""
        ENGTitle = json["ENGtitle"] as? String ?? ""
    }
}

var queryResult = [String : String]()
class SearchResult: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,Search_FilterViewControllerDelegate {
    var fetchState = false
    var currentPage = 1
    var clickedItem :Int?
    var lastPage = false
    @IBOutlet weak var noResult: UIView!
    //GET request
    func performSearch(_ url: String, completion: @escaping ([String : Any]?, Error?) -> Void) {
        
        if !fetchState
        {
            self.noResult.isHidden = true
            self.loading.isHidden = false
        }
        var components = URLComponents(string: url)!
        components.queryItems = queryResult.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        print("url",components.url)
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }
            
            guard
                let jsonObj = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
                    return
            }
                
            
            
            if let temp = self.convertToDictionary(text: jsonObj["numpost"] as! String)
            {
                print(temp)
               
          
                let deadlineTime = DispatchTime.now() + .seconds(2)
              
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    if !self.fetchState
                    {
                        self.result_show.removeAll()
                    }
                    if temp.count == 0{
                        self.lastPage = true
                        
                    }
                    for tp in temp
                    {
                        let tpx=(tp as! [String:Any])
                        self.result_show.append(result(json: tpx)
                        )
                    }
                    print(self.result_show)
                    if !self.fetchState
                    {
                        
                        self.resultCollection.reloadData()
                        self.loading.isHidden = true
                     if self.result_show.count > 0 {
                        self.resultCollection?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: true)
                    }
                     else{
                        self.noResult.isHidden = false
                        }
                        
                    }
                    else{
                        self.fetchState = false
                        self.resultCollection.reloadData()
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
      
    }
        task.resume()
    }
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat
        let height : CGFloat
        if indexPath.section == 0 {
            // First section
            width = collectionView.frame.width
            height = collectionView.frame.width
            return CGSize(width: width,height: height)
        } else {
            // Second section
            width = collectionView.frame.width
            height = 50
            return CGSize(width: width,height: height)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return result_show.count
        }
        else if section == 1 && fetchState{
            return 1
        }
        return 0
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
        if indexPath.section == 0
        {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCellIdentifier", for: indexPath) as! resultCell
            
        print("indexpath",indexPath.item)

        if result_show.count == 0{
            return cell
        }
        cell.m_title.text = result_show[indexPath.item].CHtitle
        
        cell.m_title.sizeToFit()
        cell.m_image.layer.cornerRadius = 5.0
        cell.m_image.layer.borderWidth = 1.0
        cell.m_image.layer.borderColor = UIColor.clear.cgColor
        cell.m_image.layer.masksToBounds = true
        print(search_query)
        /*
            let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0,y: cell.frame.height,width: cell.frame.width,height: 0.5)
        
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.bounds = bottomLine.frame.insetBy(dx: 10.0, dy: 10.0)
        cell.layer.addSublayer(bottomLine)
 */
    cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingPaging", for: indexPath) as! loadingPaging
            cell.spinner.startAnimating()
            
            return cell
        }
    }
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.resultCollection)
        let indexPath = self.resultCollection.indexPathForItem(at: location)
        
        if let index = indexPath {
            clickedItem = self.result_show[index.item].id
            print("Got clicked on id: \(self.result_show[index.item].id)!")
            performSegue(withIdentifier: "showResult", sender: self)
        }
    }
    let sortTab: SortTab = {
        let sb = SortTab()
        return sb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchQifExist(search_query: search_query)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchResult.back(sender:)))
        setupToolbar()
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
        newBackButton.tintColor = UIColor.brown
        self.navigationItem.leftBarButtonItem =  newBackButton
        
           resultCollection.register(UINib(nibName: "resultCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        let tempx = UINib(nibName: "loadingPaging", bundle: nil)
          resultCollection.register(tempx, forCellWithReuseIdentifier: "loadingPaging")
        resultCollection.delegate = self as UICollectionViewDelegate
        resultCollection.dataSource = self as UICollectionViewDataSource
        print("reloadx:",self.result_show.count)
        
        
    }
    func addSearchQifExist(search_query: String)
    {
        queryResult["q"] = search_query
        requestByQuery()
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
            else if identifier == "showResult"
            {
                var ResultTable = segue.destination as! ResultController
                ResultTable.index = self.clickedItem!
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
            queryResult["sort"] = "default"
            requestByQuery()
        }
        else if segmentIndex == 1{
             queryResult["sort"] = "popular"
            requestByQuery()
        }
        else
        {
             queryResult["sort"] = "price"
            requestByQuery()
        }
        
    }
    func requestByQuery(){
        if !fetchState
        {
            self.currentPage = 1
        }
        else
        {
            self.currentPage = self.currentPage + 1
        }
        self.lastPage = false
        queryResult["page"] = String(self.currentPage)
        self.performSearch("http://59.148.36.170:8000/filter/") { responseObject, error in
            guard let responseObject = responseObject, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            
            // use `responseObject` here
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
    
 
    @objc func back(sender: UIBarButtonItem) {
        queryResult.removeAll()
         self.dismiss(animated: true, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height
        {
            if !fetchState && !lastPage{
                beginBatchFetch()
            }
        }
    }
    func beginBatchFetch(){
        fetchState = true
        
        print("currentPage",currentPage)
        resultCollection.reloadSections(IndexSet(integer: 1))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
            
            self.requestByQuery()
            
        })
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
