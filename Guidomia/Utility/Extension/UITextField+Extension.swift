//
//  UITextField+Extension.swift
//  Guidomia
//
//  Created by Ajay Vyas on 31/10/21.
//

import Foundation
import UIKit

extension UITextField {
    
    //Shadow for textfield
    func showShadowTextField() {
        
        self.borderStyle = .none
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.shadowColor = UIColor.black.cgColor
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
}
