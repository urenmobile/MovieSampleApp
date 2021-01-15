//
//  BaseUseCase.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation
import URENCombine
import URENCore

public class BaseUseCase<Input, Output>: UseCase {
    
    public typealias Input = Input
    public typealias Output = Future<Output, Error>
    
    public func execute(_ input: Input) -> Future<Output, Error> {
        FatalHelper.notImplementedError()
    }
}
