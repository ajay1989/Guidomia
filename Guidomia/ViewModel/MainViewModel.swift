//
//  MainViewModel.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation
import CoreData

protocol MainModelDelegate{
    func showAlert(title: String)
}

class MainViewModel : NSObject {
    
    var service: Service?
    var delegate:MainModelDelegate?
    var vehicleData: [Vehicle]? {
        didSet {
            self.bindVehicleViewModel()
        }
    }
    var vehicleList: [Vehicle]?
    var bindVehicleViewModel : (() -> ()) = {}
    
    override init() {
        
        super.init()
        self.service = Service()
        getVehicleData()
    }
    
    /// Call to fetch all vehicle data
    func getVehicleData() {
        
        /// check if data is already there in coredata or not
        if CoreDataManager.sharedManager.fetchAllVehicle() {
            
            self.fetchFromVehicleList()  /// fetch vehicle from coredata
        } else {
            
            self.service?.fetchVehicleDataFromJson(jsonFilename: kCarList) { [weak self] (response: [Vehicle]?) in
                
                if response != nil {
                    for data in response ?? [Vehicle]() {
                        /// Insert all vehicle data to coredata
                        if CoreDataManager.sharedManager.insertVehicle(vehicleData: data) {
                            // Data inserted
                        }
                    }
                    let _ = CoreDataManager.sharedManager.fetchAllVehicle()  
                    
                    self?.fetchFromVehicleList()  /// fetch vehicle from coredata
                } else {
                    DispatchQueue.main.async {
                        self?.delegate?.showAlert(title: kErrorJsonParsing)
                    }
                }
            }
        }
    }
    
    /// Fetch vehicle list from coredata
    func fetchFromVehicleList() {
        
        let coreObjectArray: [NSManagedObject] = CoreDataManager.sharedManager.vehicleCoredata ?? [NSManagedObject]()
        self.service?.fetchDataFromNSManagedObject(managedObjects: coreObjectArray,
                                                   completion: { [weak self] (response: [Vehicle]?) in
            
            if response != nil {
                self?.vehicleData = response
                self?.vehicleList = response
                self?.expandFirstCell()
            } else {
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: kErrorJsonParsing)
                }
            }
        })
    }
    
    /// Update data after did select on tableview
    /// - Parameter list: list of vehicle
    /// - Parameter indexPath: Indexpath of tableviewcell
    /// - Parameter completion: completion handler after seting up data in model
    func updateTableViewOnDidSelect(list: [Vehicle], indexPath: IndexPath,
                                    completion: () -> ()) {
        
        let vehcileList = list
        let listCount = vehcileList.count
        
        if vehcileList[indexPath.row - 1].collapse == false {
            let data = vehcileList[indexPath.row - 1]
            data.collapse = true
            
        } else {
            for i in 0..<listCount {
                let data = vehcileList[i]
                data.collapse = i == indexPath.row - 1 ? false : true
            }
            
        }
        completion()
    }
    
    /// filter implementation for vehicle
    /// - Parameter make: vehicle make passed as string
    /// - Parameter model: vehicle model passed as string
    func filterForVehcile(make: String, model: String) {
        
        self.vehicleData?.removeAll()
        if !make.isEmpty && model.isEmpty {
            self.vehicleData = self.vehicleList?.filter({$0.make == make})
        } else {
            self.vehicleData = self.vehicleList?.filter({$0.make == make && $0.model == model})
        }
        self.expandFirstCell()
    }
    
    /// functionality to expand first cell from the list
    func expandFirstCell() {
        
        let list = self.vehicleData ?? [Vehicle]()  
        for i in 0..<list.count {
            let data = list[i]
            data.collapse = i == 0 ? false : true
        }
    }
    
    /// Reset all data
    func resetData() {
        
        self.vehicleData?.removeAll()
        self.vehicleData = self.vehicleList
        self.expandFirstCell()
    }
}
