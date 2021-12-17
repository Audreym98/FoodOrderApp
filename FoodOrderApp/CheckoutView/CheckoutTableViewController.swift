//
//  CheckoutTableViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 12/11/21.
//

import UIKit

class CheckoutTableViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    // Summary view vars
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    @IBOutlet var deliveryTimePicker: UIDatePicker!
    
    lazy var dataSource = configureDataSource()
    
    var dateFormatter = DateFormatter()
    
    enum Section {
        case all
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        navigationController?.navigationBar.tintColor = .white
        tableView.dataSource = dataSource
        // want to display a restaurant in a section
        var snapshot = NSDiffableDataSourceSnapshot<Section, MenuItem>()
        snapshot.appendSections([.all])
        let menuItems: [MenuItem] = Array(ShoppingCart.shared.cart.keys)
        snapshot.appendItems(menuItems, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        // set up summary view
        subtotalLabel.text = ShoppingCart.shared.getSubtotalFormatted()
        let currentDate = Date()
        deliveryTimePicker.minimumDate = currentDate
        deliveryTimePicker.date = currentDate
        dateFormatter.dateFormat = "MM/dd h:mm a"
    }
    
    func clearTable() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MenuItem>()
        snapshot.appendSections([.all])
        let menuItems: [MenuItem] = []
        snapshot.appendItems(menuItems, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: - Table view data source
    func configureDataSource() -> UITableViewDiffableDataSource<Section, MenuItem > {
        let cellIdentifer = "itemCell"
        let dataSource = UITableViewDiffableDataSource<Section, MenuItem>(
            tableView: tableView,
            cellProvider: {
                tableView, indexPath, menuItem in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! CheckoutItemCell
                cell.itemLabel.text = menuItem.name
                cell.priceLabel.text = menuItem.price
                cell.quantityLabel.text = String(ShoppingCart.shared.getQuantity(item: menuItem))
                cell.quantityStepper.value = Double(ShoppingCart.shared.getQuantity(item: menuItem))
                cell.item = menuItem
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        )
        return dataSource
    }
    
    @IBAction func confirmCheckout(sender: UIButton) {
        let formattedDate = dateFormatter.string(from: deliveryTimePicker.date)
        let alertController = UIAlertController(title: "Your order has been placed!", message: "subtotal: \(subtotalLabel.text ?? "$0.00"), delivery time: \(formattedDate)", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        ShoppingCart.shared.clearCart()
        subtotalLabel.text = ShoppingCart.shared.getSubtotalFormatted()
        clearTable()
    }
}

extension CheckoutTableViewController : CheckoutTableViewCellDelegate {
    func updateSubtotal(_ checkoutTableViewCell: CheckoutItemCell) {
        // update subtotal label
        self.subtotalLabel.text = ShoppingCart.shared.getSubtotalFormatted()
  }
}
