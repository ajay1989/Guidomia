//
//  Service.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation

class Service: NSObject {
    
    //Fetch from Local file json
    func fetchVehicleDataFromJson<T: Decodable>(input: String,
                                                completion : @escaping (_ response: T) -> ()) {
        
        do {
            guard let jsonUrl = Bundle.main.url(forResource: input, withExtension: kJson) else {
                return
            }
            let data = try Data(contentsOf: jsonUrl)
            let response = try JSONDecoder().decode(T.self, from: data)
            completion(response)
        }
        catch {
            // TO DO: Handeling arror when unable to read json
            print(error)
        }
    }
}
