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
    var item: MenuItem = MenuItem(name: "", imageString: "", type: "", price: "", description: "")
    weak var delegate : CheckoutTableViewCellDelegate? = nil

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
        let curQuantity = Int(quantityLabel.text!) ?? 0
        if curQuantity != Int(sender.value) {
            if Int(sender.value) > curQuantity {
                // quantity increased
                ShoppingCart.shared.addToCart(item: self.item, quantity: "1")
            } else {
                // quantity decreased
                ShoppingCart.shared.removeOneFromCart(item: self.item)
            }
            quantityLabel.text = Int(sender.value).description
            // update the subtotal label
            if delegate != nil {
                self.delegate?.updateSubtotal(self)
            }
        }
    }
}

protocol CheckoutTableViewCellDelegate: AnyObject {
    func updateSubtotal(_  checkoutTableViewCell: CheckoutItemCell)
}
