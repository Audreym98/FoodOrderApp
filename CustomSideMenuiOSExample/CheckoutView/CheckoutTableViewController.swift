//
//  CheckoutTableViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 12/11/21.
//

import UIKit

class CheckoutTableViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    // Summary view
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    
    lazy var dataSource = configureDataSource()
    
    // what does this mean?
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        let menuItems: [Restaurant] = Array(ShoppingCart.shared.cart.keys)
        snapshot.appendItems(menuItems, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        // set up summary view
        subtotalLabel.text = ShoppingCart.shared.getSubtotalFormatted()
    }

    // MARK: - Table view data source
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant > {
        let cellIdentifer = "itemCell"
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(
            tableView: tableView,
            cellProvider: {
                tableView, indexPath, menuItem in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! CheckoutItemCell
                cell.itemLabel.text = menuItem.name
                cell.priceLabel.text = menuItem.price
                cell.quantityLabel.text = String(ShoppingCart.shared.getQuantity(item: menuItem))
                cell.quantityStepper.value = Double(ShoppingCart.shared.getQuantity(item: menuItem))
                return cell
            }
        )
        return dataSource
    }
    
    @IBAction func confirmCheckout(sender: UIButton) {
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
