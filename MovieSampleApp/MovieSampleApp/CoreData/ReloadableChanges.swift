//
//  ReloadableChanges.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation

public struct ReloadableChanges {
    public let insertItems: [IndexPath]
    public let deleteItems: [IndexPath]
    public let reloadItems: [IndexPath]
    public let moveItems: [(from: IndexPath, to: IndexPath)]
}
