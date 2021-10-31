//
//  Service.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation

class Service: NSObject {
    
    //Fetch from Local file json
    func fetchVehicleDataFromJson(input: String,
                                  completion : @escaping ([Vehicle]) -> ()) {
        
        do {
            guard let jsonUrl = Bundle.main.url(forResource: input, withExtension: kJson) else {
                return
            }
            let data = try Data(contentsOf: jsonUrl)
            let response = try JSONDecoder().decode([Vehicle].self, from: data)
            completion(response)
        }
        catch {
            print(error)
        }
    }
}
