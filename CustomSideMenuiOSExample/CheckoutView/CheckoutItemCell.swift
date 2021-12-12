//
//  CheckoutItemCell.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 12/11/21.
//

import UIKit

class CheckoutItemCell: UITableViewCell {
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
