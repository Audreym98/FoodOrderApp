//
//  MenuTableViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 10/13/21.
//

import UIKit

class MenuTableViewController: UITableViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var menuItems: [MenuItem] = []
    var defaults = UserDefaults.standard
    var selectedRowIndex: Int?
    
    // lazy: initial value cannot be retrieved until instance initialization
    lazy var dataSource = configureDataSource()
    
    enum Section {
        case all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        navigationController?.navigationBar.tintColor = .white
        // assign custom dataSource to
        // table view's data source
        tableView.dataSource = self.dataSource
        // create snapshot of current data to display
        var snapshot = NSDiffableDataSourceSnapshot<Section, MenuItem>()
        // add section to snapshot
        snapshot.appendSections([.all])
        // add menu items to .all section
        snapshot.appendItems(self.menuItems, toSection: .all)
        // apply snapshot to data source to display
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.separatorStyle = .none
    }
    
    // first line is func declaration and return an instance
    func configureDataSource() -> UITableViewDiffableDataSource<Section, MenuItem > {
        let cellIdentifer = "favoritecell"
        // creates instance of object
        // instance it will connect to tableView and cell provider
        // cellProvider parameter sets up each cell
        // stuff in cell provider looks the same as the SimpleTable demo
        let dataSource = UITableViewDiffableDataSource<Section, MenuItem>(
            tableView: tableView,
            cellProvider: {
                tableView, indexPath, menuItem in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! MenuTableViewCell
                let itemName = menuItem.name
                cell.nameLabel.text = itemName
                cell.priceLabel.text = menuItem.price
                cell.typeLabel.text = menuItem.type
                // what image to display
                cell.thumbnailImageView.image = UIImage(named: self.menuItems[indexPath.row].imageString)
                // determine if the menu item in this cell has been liked
                if (self.defaults.object(forKey: itemName) == nil) {
                    self.menuItems[indexPath.row].isFavorite = false
                    cell.heartImageView.isHidden = true
                } else {
                    // exists as a liked menu item
                    // update menu item value and cell
                    self.menuItems[indexPath.row].isFavorite = true
                    cell.heartImageView.isHidden = false
                }
                return cell
            }
        )
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath
    : IndexPath) {
        self.selectedRowIndex = indexPath.row
        // Create an option menu as an actionsheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        // sets menu location for iPad
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
            }
        }
        // Add cancel action to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        let isFavorite = self.menuItems[indexPath.row].isFavorite ?? false
        // Mark or unmark as favorite action
        if isFavorite {
            // if marked as favorite, present unfavorite action
            let unfavoriteActionHandler = {
                (action:UIAlertAction!) -> Void in
                // retrieve selected cell
                let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
                // remove heart
                cell.heartImageView.isHidden = true
                // update sFavorite
                self.menuItems[indexPath.row].isFavorite = false
                // remove from defaults
                self.defaults.removeObject(forKey: self.menuItems[indexPath.row].name)
            }
            let unfavoriteAction  = UIAlertAction(title: "Remove as favorite", style: .default, handler: unfavoriteActionHandler)
            optionMenu.addAction(unfavoriteAction)
        } else {
            // if not marked as favorite, present favorite action
            let favoriteActionHandler = {
                (action:UIAlertAction!) -> Void in
                // retrieve selected cell
                let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
                // show heart
                cell.heartImageView.isHidden = false
                // update isFavorite
                self.menuItems[indexPath.row].isFavorite = true
                // add to defaults
                self.defaults.setValue(true, forKey: self.menuItems[indexPath.row].name)
            }
            let favoriteAction  = UIAlertAction(title: "Mark as favorite", style: .default, handler: favoriteActionHandler)
            optionMenu.addAction(favoriteAction)
        }
        let detailActionHandler = {
            (action:UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "showMenuItemDetail", sender: self)
        }
        let detailAction  = UIAlertAction(title: "View more details", style: .default, handler: detailActionHandler)
        optionMenu.addAction(detailAction)
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenuItemDetail" {
            if let indexPath = self.selectedRowIndex {
                // recieve destination controller
                let destinationController = segue.destination as! MenuDetailViewController
                destinationController.menuItem = self.menuItems[indexPath]
            }
        }
    }
}

