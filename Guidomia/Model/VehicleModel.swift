//
//  VehicleModel.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation

// Model class for Vehicle
class Vehicle: Decodable {
    
    let consList : [String]?
    let customerPrice : Int?
    let make : String?
    let marketPrice : Int?
    let model : String?
    let prosList : [String]?
    let rating : Int?
    var collapse: Bool = true
    enum CodingKeys: String, CodingKey {
        
        case consList = "consList"
        case customerPrice = "customerPrice"
        case make = "make"
        case marketPrice = "marketPrice"
        case model = "model"
        case prosList = "prosList"
        case rating = "rating"
    }
}
