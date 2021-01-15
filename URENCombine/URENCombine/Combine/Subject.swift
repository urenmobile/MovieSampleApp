//
//  Subject.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol Subject: AnyObject, Publisher {
    func send(_ value: Output)
    func send(completion: Subscribers.Completion<Failure>)
}

extension Subject where Output == Void {
    public func send() {
        send(())
    }
}
