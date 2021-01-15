//
//  Publisher.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol Publisher {
    associatedtype Output
    associatedtype Failure: Error
}
