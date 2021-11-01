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
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Guidomia")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
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
    
  /*Insert*/
    func insertVehicle(vehicleData:Vehicle) -> Bool {
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "VehicleList",
                                            in: managedContext)!
    let vehicle = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
        vehicle.setValue(vehicleData.consList, forKeyPath: "consList")
        vehicle.setValue(vehicleData.customerPrice, forKeyPath: "customerPrice")
        vehicle.setValue(vehicleData.make, forKeyPath: "make")
        vehicle.setValue(vehicleData.marketPrice, forKeyPath: "marketPrice")
        vehicle.setValue(vehicleData.model, forKeyPath: "model")
        vehicle.setValue(vehicleData.prosList, forKeyPath: "prosList")
        vehicle.setValue(vehicleData.rating, forKeyPath: "rating")
    do {
      try managedContext.save()
      return true
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
      return false
    }
  }
  
  func fetchAllVehicle() -> [NSManagedObject]? {
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "VehicleList")
    do {
      let vehicle = try managedContext.fetch(fetchRequest)
        return vehicle
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return [NSManagedObject]()
    }
  }
}
