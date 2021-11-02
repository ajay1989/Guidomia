//
//  Service.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import Foundation
import CoreData

class Service: NSObject {
    
    // Fetch from Local file json
    /// - Parameter jsonFilename: takes input json file
    /// - Parameter completion: send response
    func fetchVehicleDataFromJson<T: Decodable>(jsonFilename: String,
                                                completion : @escaping (_ response: T?) -> ()) {
        
        do {
            guard let jsonUrl = Bundle.main.url(forResource: jsonFilename, withExtension: kJson) else {
                completion(nil)
                return
            }
            let data = try Data(contentsOf: jsonUrl)
            let response = try JSONDecoder().decode(T.self, from: data)
            completion(response)
        }
        catch {
            completion(nil)
        }
    }
    
    // Fetch from NSManagedObject array to codeable model
    /// - Parameter managedObjects: input NSManagedObject array
    /// - Parameter completion: send response
    func fetchDataFromNSManagedObject<T: Decodable>(managedObjects: [NSManagedObject],
                                                    completion : @escaping (_ response: T?) -> ()) {
        
        do {
            let json = convertToJSONArray(managedObjectArray: managedObjects)
            let jsonData = json.data(using: .utf8)!
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            completion(response)
        }
        catch {
            completion(nil)
        }
    }
    
    // function ro convert NSManagedOject convert to json string
    /// - Parameter managedObjectArray: input NSManagedObject array
    /// - Returns: json string else return blank string
    func convertToJSONArray(managedObjectArray: [NSManagedObject]) -> String {
        
        var jsonArray: [[String: Any]] = []
        
        for item in managedObjectArray {
            var dict: [String: Any] = [:]
            
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        do {
            let data =  try JSONSerialization.data(withJSONObject: jsonArray,
                                                    options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data, encoding: String.Encoding.utf8).unwrappedValue
            return convertedString
        } catch {
            return ""
        }
    }
}
