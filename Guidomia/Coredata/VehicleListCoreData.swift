//
//  VehicleListCoreData.swift
//  Guidomia
//
//  Created by Ajay Vyas on 01/11/21.
//

import Foundation
import CoreData

@objc(VehicleCoreData)
public class VehicleCoreData: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<VehicleCoreData> {
        return NSFetchRequest<VehicleCoreData>(entityName: kEntityName)
    }

    @NSManaged public var consList: [String]? 
    @NSManaged public var customerPrice: NSNumber?
    @NSManaged public var make: String?
    @NSManaged public var marketPrice: NSNumber?
    @NSManaged public var model: String?
    @NSManaged public var prosList: [String]?
    @NSManaged public var rating: NSNumber?
}
