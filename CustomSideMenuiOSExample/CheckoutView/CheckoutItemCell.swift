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
    @IBOutlet var quantityStepper: UIStepper!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func quantityChanged(_ sender: UIStepper) {
        // assign value of stepper to quantity label
        quantityLabel.text = Int(sender.value).description
        // update amount in cart
    }

}
