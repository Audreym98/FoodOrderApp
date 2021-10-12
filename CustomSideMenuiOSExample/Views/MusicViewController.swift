//
//  MusicViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/9/21.
//

import UIKit

class MusicViewController: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }
}
