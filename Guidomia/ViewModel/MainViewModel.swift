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
    
    private var service: Service?
    var delegate:MainModelDelegate?
    private(set) var vehicleData: [Vehicle]? {
        didSet {
            self.bindVehicleViewModel()
        }
    }
    var vehicleList: [Vehicle]?
    var bindVehicleViewModel : (() -> ()) = {}
    
    // Initilisation of ViewModelClass
    override init() {
        
        super.init()
        self.service = Service()
        getVehicleData()
    }
    
    // Call to fetch all vehicle data
    func getVehicleData() {
        
        if CoreDataManager.sharedManager.fetchAllVehicle()?.count ?? 0 > 0 {
            self.fetchFromVehicleList()
        } else {
            self.service?.fetchVehicleDataFromJson(input: kCarList) { [weak self] (response:[Vehicle]?) in
                
                if response != nil {
                    for data in response ?? [Vehicle]() {
                        if CoreDataManager.sharedManager.insertVehicle(vehicleData: data) {
                            // Data inserted successfully
                        }
                    }
                    self?.fetchFromVehicleList()
                } else {
                    DispatchQueue.main.async {
                        self?.delegate?.showAlert(title: kErrorJsonParsing)
                    }
                }
            }
        }
    }
    
    func fetchFromVehicleList() {
        
        do {
            let coreObjectArray: [NSManagedObject] = CoreDataManager.sharedManager.fetchAllVehicle() ?? [NSManagedObject]()
            let json = self.convertToJSONArray(moArray: coreObjectArray)
            let jsonString = self.jsonToString(json: json)
            let jsonData = jsonString.data(using: .utf8)!
            let user = try JSONDecoder().decode([Vehicle].self, from: jsonData)
            self.vehicleData = user
            self.vehicleList = user
            self.expandFirstCell()
        } catch {
            DispatchQueue.main.async {
                self.delegate?.showAlert(title: kErrorJsonParsing)
            }
        }
        
    }
    
    func convertToJSONArray(moArray: [NSManagedObject]) -> Any {
        
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
    func jsonToString(json: Any) -> String {
        
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) ?? ""
            return convertedString
        } catch {
            return ""
        }
        
    }
    
    func updateTableViewOnDidSelect(list: [Vehicle],
                                    indexPath: IndexPath,
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
    
    func filterForVehcile(make: String,
                          model: String) {
        
        self.vehicleData?.removeAll()
        if !make.isEmpty && model.isEmpty {
            self.vehicleData = self.vehicleList?.filter({$0.make == make})
        } else {
            self.vehicleData = self.vehicleList?.filter({$0.make == make && $0.model == model})
        }
        self.expandFirstCell()
    }
    
    func expandFirstCell() {
        let list = self.vehicleData ?? [Vehicle]()
        for i in 0..<list.count {
            let data = list[i]
            data.collapse = i == 0 ? false : true
        }
    }
    
    func resetData() {
        self.vehicleData?.removeAll()
        self.vehicleData = self.vehicleList
        self.expandFirstCell()
    }
}
