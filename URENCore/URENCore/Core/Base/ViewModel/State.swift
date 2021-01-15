//
//  State.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public enum State {
    case loading
    case populate
    case empty
    case failure(Alert)
}
