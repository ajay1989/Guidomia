//
//  BaseViewController.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Set Navigation title dynamically
    func setNavigationTitle(title:String) {
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = title
        label.font = UIFont(name: kDidotBoldFont, size: 28.0) ?? UIFont.systemFont(ofSize: 22.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
}
