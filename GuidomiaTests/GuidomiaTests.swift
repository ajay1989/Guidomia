//
//  GuidomiaTests.swift
//  GuidomiaTests
//
//  Created by Ajay Vyas on 30/10/21.
//

import XCTest
@testable import Guidomia

class GuidomiaTests: XCTestCase {
    
    func testResetData() {
        
        let mainViewModel = MainViewModel()
        mainViewModel.service?.fetchVehicleDataFromJson(jsonFilename: kCarList,
                                                        completion: { [weak self] (response: [Vehicle]?) in
                                                            
                                                            mainViewModel.vehicleData = response
                                                            XCTAssertNotNil(mainViewModel.vehicleData)
                                                        })
    }
}
