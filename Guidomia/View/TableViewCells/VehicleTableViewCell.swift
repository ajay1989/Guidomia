//
//  VehicleTableViewCell.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var viewRating: CosmosView!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblModelName: UILabel!
    @IBOutlet private weak var imgVehicle: UIImageView!
    var vehicleModelData:Vehicle?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //SetUp UI Data
    func setData() {
        
        guard let vehcileData = vehicleModelData else {
            return
        }
        lblModelName.text = "\(vehcileData.make.unwrappedValue) \(vehcileData.model.unwrappedValue)"
        lblPrice.text = "Price : \(vehcileData.customerPrice.unwrappedValue/1000)k"
        viewRating.totalStars = vehcileData.rating.unwrappedValue
        imgVehicle.image = UIImage(named: "\(vehcileData.make.unwrappedValue) \(vehcileData.model.unwrappedValue)")
    }
    
}
