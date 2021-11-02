//
//  UITableView+Extension.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation
import UIKit

extension UITableView {
    
    /// Register of tableviewcell
    /// - Parameter nibName: nibname pass as string
    func autoLayoutRegisterNib(nibName:String?) {
        
        if let nibName = nibName {
            self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
    }
}
