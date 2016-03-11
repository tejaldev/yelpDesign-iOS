//
//  NavControllerViewController.swift
//  yelpApp
//
//  Created by Tejal Par on 9/22/14.
//

import UIKit

class NavControllerViewController: UINavigationController, UISearchBarDelegate {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var uiSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let searchBar = UISearchBar(frame: CGRectMake(-5.0, 0.0, 320.0, 44.0))
        searchBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        let searchBarView = UIView(frame: CGRectMake(0.0, 0.0, 310.0, 44.0))
        searchBarView.autoresizingMask = UIViewAutoresizing.None
        
        searchBar.delegate = self
        searchBarView.addSubview(searchBar)
        self.navigationItem.titleView = searchBarView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
