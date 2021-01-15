//
//  Alert.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol Alert {
    var title: String? { get }
    var message: String? { get }
    var style: AlertStyle { get }
    var actions: [AlertAction] { get }
}
