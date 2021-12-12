//
//  DetailOrderCell.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 11/17/21.
//

import UIKit

class DetailOrderCell: UITableViewCell {
    
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var quantityStepper: UIStepper!
    @IBOutlet var orderButton: UIButton!
    var item: Restaurant = Restaurant(name: "", imageString: "", type: "", price: "", description: "")
    weak var delegate : DetailTableViewCellDelegate?
    
    @IBAction func quantityChanged(_ sender: UIStepper) {
        // assign value of stepper to quantity label
        quantityLabel.text = Int(sender.value).description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.orderButton.addTarget(self, action: #selector(orderTapped(_:)), for: .touchUpInside)
        self.orderButton.setTitle("Add to cart", for: .normal)
        self.orderButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func orderTapped(_ sender: UIButton) {
        // display order confirmation in a pop-up
        if delegate != nil {
            self.delegate?.detailTableViewCell(self, orderTappedFor: self.item.name, orderQuantityFor: quantityLabel.text ?? "1")
        }
        
        // update cart
        ShoppingCart.shared.addToCart(item: self.item, quantity: quantityLabel.text ?? "1")
    }
}

protocol DetailTableViewCellDelegate: AnyObject {
    func detailTableViewCell(_  detailTableViewCell: DetailOrderCell, orderTappedFor itemName: String, orderQuantityFor quantity: String)
}
