//
//  FilterCell.swift
//  yelpApp
//
//  Created by Tejal Par on 9/23/14.

import UIKit

class FilterCell: UITableViewCell {

    
    @IBOutlet var filterDealsSwitch: UISwitch!
    
    @IBOutlet var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
