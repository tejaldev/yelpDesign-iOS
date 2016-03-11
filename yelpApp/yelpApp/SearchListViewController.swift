//
//  SearchListViewController.swift
//  yelpApp
//
//  Created by Tejal Par on 9/22/14.
//

import UIKit

class SearchListViewController: UITableViewController, UISearchBarDelegate, CLLocationManagerDelegate, FilterViewControllerDelegate  {
//UITableViewDataSource, UITableViewDelegate,
    var client: YelpClient!
    var uiSearchBar: UISearchBar!
    var filterButton: UIButton!
    var locationManager: CLLocationManager!
    var businessDict: [NSDictionary] = []
    var currentLatitute: CLLocationDegrees!
    var currentLongitue: CLLocationDegrees!
    
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var searchText: UILabel!
    
    
    @IBOutlet var itemImageView: UIImageView!
    
    
    @IBOutlet var distanceLabel: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        self.filterButton = UIButton(frame: CGRectMake(-5, 0, 60, 42))
        self.filterButton.contentEdgeInsets.left = 4
        //self.filterButton.contentEdgeInsets.right = 4
        self.filterButton.addTarget(self, action: "pressedButton" , forControlEvents: UIControlEvents.TouchUpInside)
        self.filterButton.setTitle("Filter", forState: UIControlState.Normal)
        self.filterButton.backgroundColor = UIColor.redColor()
        
        
        let searchBar = UISearchBar(frame: CGRectMake(60.0, 0.0, 320.0, 42.0))
        searchBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        searchBar.barTintColor = UIColor.redColor()
        
        //var searchBarView = UIView(frame: CGRectMake(0.0, 0.0, 310.0, 44.0))
        let searchBarView = UIView(frame: CGRectMake(0.0, 0.0, 310.0, 44.0))
        searchBarView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        searchBar.delegate = self
        searchBarView.addSubview(self.filterButton)
        
        searchBarView.addSubview(searchBar)
        self.navigationItem.titleView = searchBarView
        
        
        
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 83.0
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let pullToRefreshControl = UIRefreshControl()
        pullToRefreshControl.addTarget(self, action: "loadResults:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = pullToRefreshControl
        
        let serachText : NSString? = searchBar.text
        if serachText != nil {
            self.loadResults(serachText!)
        }
        else{
            self.loadResults("Thai")
        }
        
        let uiSearchBar = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let serachText : NSString? = searchBar.text
        if serachText != nil {
            self.loadResults(serachText!)
        }
        else{
            self.loadResults("Thai")
        }
    }
    
    func loadResults(searchText: NSString){
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(searchText as String, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            self.businessDict = response["businesses"] as! [NSDictionary]
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print(error)
                
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.businessDict.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchItemCell", forIndexPath: indexPath) as! SearchItemCell
        
        var bussiness = self.businessDict[indexPath.row]
        //println(bussiness)
        
        let name = bussiness["name"] as! String
        cell.titleLabel.text = "\(indexPath.row+1).\(name)"
        
        let url = bussiness["image_url"] as! String
        cell.itemImageView.setImageWithURL(NSURL(string:url))
        
        let rurl = bussiness["rating_img_url"] as! String
        cell.ratingImageView.setImageWithURL(NSURL(string:rurl))
        
        let reviewCount = bussiness["review_count"] as! Int
        let str3 = " reviews"
        cell.countLabel.text = "\(reviewCount)\(str3)"
        
        let loc = bussiness["location"] as! NSDictionary
        let address = loc["address"]as! [String]
        if(address.count>0){
            cell.addressLabel.text = address[0]
        }
        
        let cor = loc["coordinate"] as! NSDictionary?
        if cor != nil {
            let lat = cor!["latitude"] as! NSNumber
            let long = cor!["longitude"] as! NSNumber
            
            
//            let locA = CLLocation(latitude: currentLatitute, longitude: currentLongitue)
//            let locB = CLLocation(latitude: lat, longitude: long)
//            let distance = locA.distanceFromLocation(locB)
//            println(distance)
        }
        
        let categories = bussiness["categories"] as! [NSArray]
        var temp = ""
        for item in categories{
            temp+=item[0] as! String
        }
        cell.searchTextLabel.text=temp
        
        return cell
    }
    
    func applyFilter(controller: FilterViewController, category: String, sort: Int, radius: Int) {
      controller.dismissViewControllerAnimated(true, completion: nil)
        
        let serachText : NSString? = self.uiSearchBar.text
        if serachText == nil {
            let serachText = "Thai"
        }
        
        client.searchWithFilter(serachText! as String,sort:sort  ,distance:radius,success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businessDict = response["businesses"] as! [NSDictionary]
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print(error)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            var coord = locationObj.coordinate
            
            print(coord.latitude)
            print(coord.longitude)
        
        locationManager.stopUpdatingLocation()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "mSegue"{
            let vc = segue.destinationViewController as! FilterViewController
            vc.delegate = self
            
        }
    }
    
    
    func buttonAction(sender:UIButton!)
    {
        
    }

}
