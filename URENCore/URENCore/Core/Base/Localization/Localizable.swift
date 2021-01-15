//
//  Localizable.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

public extension Localizable {
    // default Localizable.strings file name
    var tableName: String {
        return "Localizable"
    }
}

public extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}

extension String {
    /// Use for localization
    public func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "###\(self)###", comment: "")
    }
}
