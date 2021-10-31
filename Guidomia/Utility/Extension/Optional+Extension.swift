//
//  Optional+Extension.swift
//  Guidomia
//
//  Created by Ajay Vyas on 31/10/21.
//

import Foundation

protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Optional where Wrapped: Defaultable {
    var unwrappedValue: Wrapped { return self ?? Wrapped.defaultValue }
}

extension Int: Defaultable {
    static var defaultValue: Int { return 0 }
}

extension String: Defaultable {
    static var defaultValue: String { return "" }
}

extension Double: Defaultable {
    static var defaultValue: Double { return 0 }
}
