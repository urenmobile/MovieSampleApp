//
//  FatalHelper.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public class FatalHelper {
    public class func notImplementedError(file: StaticString = #file, line: UInt = #line) -> Never {
        fatalError("Base class function not implemented", file: file, line: line)
    }
}
