//
//  ViewController.swift
//  yelpApp
//
//  Created by Tejal Par on 9/21/14.
//

import UIKit

class ViewController: UIViewController {
    
    var client: YelpClient!
    
    
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            
            
            var businessArray: NSArray
            
            businessArray = response["businesses"] as! NSArray
            
            if (businessArray.count > 0) {
                var firstBusiness = businessArray.firstObject as! NSDictionary;
                var firstBusinessID = firstBusiness["id"] as! NSString;
                
                print(firstBusinessID)
                
                var firstBusinessImageUrl = firstBusiness["image_url"] as! NSString;
                
                
                //[self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
            }
            
            
            print(response)
            
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print(error)
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

