//
//  MovieCoreDataControllerProvider.swift
//  MovieSampleApp
//
//  Created by Remzi YILDIRIM on 1/14/21.
//

import Foundation
import URENDomain
import URENCombine
import URENCoreData

public protocol MovieCoreDataControllerProvider: AnyObject {
    var reloadableChangesSubject: PassthroughSubject<ReloadableChanges, Never> { get }
    func performFetch()
    func numberOfSection() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func item(at indexPath: IndexPath) -> MovieModel
    func filter(with text: String)
}
