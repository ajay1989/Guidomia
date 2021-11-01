//
//  UIViewController+Extension.swift
//  Guidomia
//
//  Created by Ajay Vyas on 01/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func popupAlert(message: String?) {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kOK, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
