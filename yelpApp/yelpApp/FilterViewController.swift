//
//  FilterViewController.swift
//  yelpApp
//
//  Created by Tejal Par on 9/23/14.
//

import UIKit

protocol FilterViewControllerDelegate{
    func applyFilter(controller:FilterViewController,category:String, sort:Int, radius:Int)
}

class FilterViewController: UITableViewController { //, UITableViewDataSource , UITableViewDelegate {
    var delegate:FilterViewControllerDelegate!
    var numInSection=[4,5,7]
    var filterString:String!="filter"
    var sortBy:Int!
    var category:String!
    var distance:Int!
    var nameInSection=["Category", "Sort By", "Distance"]
    var isExpand: [Int: Bool] = [Int: Bool] ()
    
    var table=[["Best Match","Distance","Rating","Most Reviewed"],
        ["Auto","0.3 miles","1 miles","5 miles","20 miles"],["Arts & Entertainment","Beauty & Spas","Education","Financial Services","Food","Health & Medical","Home Services","Hotels & Travel","Real Estate"]]
    
    var dictionary = ["Arts & Entertainment":"arts","Beauty & Spas":"beautysvc","Education":"education","Financial Services":"financialservices","Food":"food","Health & Medical":"health","Home Services":"homeservices","Hotels & Travel":"hotelstravel","Real Estate":"realestate"]
   // @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 40;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func search(sender: AnyObject) {
        filterString="&sort=2"
        sortBy = 2;
        distance = 1600;
        category="food"
        if (delegate != nil) {
            
            delegate!.applyFilter(self, category: category, sort: sortBy, radius: distance)
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isExpand[section] == nil || isExpand[section]==false) {
            return 1;
        } else {
            return numInSection[section];
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell") as! FilterCell
        switch (indexPath.section){
        case 0:
            cell.filterLabel.text=table[0][indexPath.row]
            cell.filterDealsSwitch.hidden = false
        case 1:
            cell.filterLabel.text=table[1][indexPath.row]
        case 2:
            cell.filterLabel.text=table[2][indexPath.row]
            
        case 3:
            cell.filterLabel.text=table[3][indexPath.row]
            
            
        default:
            cell.filterLabel.text="Thai"
        }
        
        
        return cell;
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        headerView.backgroundColor = UIColor.lightGrayColor()
        
        let Label = UILabel(frame: CGRect(x: 10, y: 20, width: 300, height: 20))
        Label.font = UIFont.systemFontOfSize(15)
        Label.text = nameInSection[section];
        headerView.addSubview(Label);
        return headerView
    }

    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (isExpand[indexPath.section] == nil || isExpand[indexPath.section] == false){
            isExpand[indexPath.section] = true
        }
        else {
            isExpand[indexPath.section] = false;
            
        }
        let rowNum = indexPath.row
        let sectionNum = indexPath.section
        let temp = table[sectionNum][rowNum]
        table[sectionNum][rowNum] = table[sectionNum][0]
        table[sectionNum][0] = temp
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
