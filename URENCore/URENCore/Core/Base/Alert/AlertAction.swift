//
//  AlertAction.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public class AlertAction {
    public typealias Handler = () -> Void
    public let title: String
    public let handler: Handler?
    
    public init(title: String, handler: Handler? = nil) {
        self.title = title
        self.handler = handler
    }
}
