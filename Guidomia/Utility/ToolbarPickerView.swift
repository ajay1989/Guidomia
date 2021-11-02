//
//  ToolbarPickerView.swift
//  Guidomia
//
//  Created by Ajay Vyas on 01/11/21.
//

import Foundation
import UIKit

/// Protocol define
protocol ToolbarPickerViewDelegate: class {
    
    func didTapDone()
    func didTapCancel()
}

class ToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?       

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: kDone,
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(title: kCancel,
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    /// done button of toolbar defined
    @objc func doneTapped() {
        
        self.toolbarDelegate?.didTapDone()
    }

    /// cancel button of toolbar defined
    @objc func cancelTapped() {
        
        self.toolbarDelegate?.didTapCancel()
    }
}
