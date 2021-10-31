//
//  Constant.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation
import UIKit

let kScreenSize = UIScreen.main.bounds.size
let kMainNavigationTitle = "GUIDOMIA"
let kAspectRatio:CGFloat = 66.6666666667
let kCarList = "car_list"
let kJson = "json"

// TableviewCell Indentifier list
struct TableCellIdentifier {
    
    let kFilterCellIdentifier = "FilterTableViewCell"
    let kVehicleCellIdentifier = "VehicleTableViewCell"
}

// Custom Color list
struct AppColors {
    
    let colorOrange = UIColor(hex: "FC6016")
    let colorDarkGrey = UIColor.init(hex: "858585")
    let colorLightGrey = UIColor(hex: "D5D5D5")
    let colorTextBlack = UIColor.black.withAlphaComponent(0.45)
    let colorTextBulletPoint = UIColor.black
}
