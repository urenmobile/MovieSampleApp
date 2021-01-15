//
//  AnyAlert.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public class AnyAlert: Alert {
    public let title: String?
    public let message: String?
    public let style: AlertStyle
    public var actions: [AlertAction]
    
    public init(title: String?, message: String?, style: AlertStyle = .alert, actions: [AlertAction]) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = actions
    }
    
    public func addAction(_ action: AlertAction) {
        actions.append(action)
    }
}
