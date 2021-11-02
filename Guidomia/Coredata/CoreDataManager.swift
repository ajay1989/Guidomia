//
//  CoreDataManager.swift
//  Guidomia
//
//  Created by Ajay Vyas on 01/11/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    var vehicleCoredata: [NSManagedObject]?
    private init() {}
    
    /// Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: kAppName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Save entries to CoreData
    func saveContext () {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// Insert Vehicle Data to coredata
    /// - Parameter vehicleData: vehicle data
    /// - Returns: true if data inserted else false
    func insertVehicle(vehicleData: Vehicle) -> Bool {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: kEntityName,
                                                in: managedContext)!
        let vehicle = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        vehicle.setValue(vehicleData.consList, forKeyPath: kConsList)
        vehicle.setValue(vehicleData.customerPrice, forKeyPath: kCustomerPrice)
        vehicle.setValue(vehicleData.make, forKeyPath: kMake)
        vehicle.setValue(vehicleData.marketPrice, forKeyPath: kMarkerPrice)
        vehicle.setValue(vehicleData.model, forKeyPath: kModel)
        vehicle.setValue(vehicleData.prosList, forKeyPath: kProsList)
        vehicle.setValue(vehicleData.rating, forKeyPath: kRating)
        
        do {
            try managedContext.save()
            return true
        } catch {
            return false
        }
    }
    
    /// Get all vehicle list from coredata
    /// - Returns: true if data found else false
    func fetchAllVehicle() -> Bool {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: kEntityName)
        do {
            self.vehicleCoredata = try managedContext.fetch(fetchRequest)
            guard let vehicle = self.vehicleCoredata, vehicle.count > 0 else {
                return false
            }
            return true
        } catch {
            return false
        }
    }
}
