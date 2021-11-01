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
    var bindVehicleViewModel : (() -> ()) = {}
    
    // Initilisation of ViewModelClass
    override init() {
        
        super.init()
        self.service = Service()
        getVehicleData()
    }
    
    // Call to fetch all vehicle data
    func getVehicleData() {
        
        self.service?.fetchVehicleDataFromJson(input: kCarList) { [weak self] (response:[Vehicle], status: Bool) in
            
            if status {
                self?.vehicleData = response
                let firstData = self?.vehicleData?.first
                firstData?.collapse = false
            } else {
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: kErrorJsonParsing)
                }
            }
        }
    }
}
