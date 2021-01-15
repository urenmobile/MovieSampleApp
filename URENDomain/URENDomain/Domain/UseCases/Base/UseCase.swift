//
//  UseCase.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public protocol UseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) -> Output
}
