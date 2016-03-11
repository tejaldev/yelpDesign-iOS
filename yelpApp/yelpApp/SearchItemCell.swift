//
//  SearchItemCell.swift
//  yelpApp
//
//  Created by Tejal Par on 9/22/14.
//

import UIKit

class SearchItemCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var searchTextLabel: UILabel!

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
