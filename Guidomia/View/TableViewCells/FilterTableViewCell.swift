//
//  FilterTableViewCell.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet private weak var txtVehicleModel: UITextField!
    @IBOutlet private weak var txtVehicleMake: UITextField!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        txtVehicleMake.showShadowTextField()
        txtVehicleModel.showShadowTextField()
    }

    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
}
