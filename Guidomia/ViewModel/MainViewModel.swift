//
//  MainViewModel.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation

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
        
        self.service?.fetchVehicleDataFromJson(input: kCarList) { [weak self] (response:[Vehicle]?) in
            
            if response != nil {
                self?.vehicleData = response
                self?.vehicleList = response
                self?.expandFirstCell()
            } else {
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: kErrorJsonParsing)
                }
            }
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
        let firstData = self.vehicleData?.first
        firstData?.collapse = false
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
