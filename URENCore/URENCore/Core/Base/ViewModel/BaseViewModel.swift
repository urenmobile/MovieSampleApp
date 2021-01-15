//
//  BaseViewModel.swift
//  URENCore
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation
import URENCombine

open class BaseViewModel: ViewModel {
    
    public private(set) var state = PassthroughSubject<State, Never>()
    public private(set) var dismissSubject = PassthroughSubject<Void, Never>()
    public let cancelBag = CancelBag()
    
    private var isDismissed = false
    
    public init() {
        
    }
    
    open func dismiss() {
        guard !isDismissed else {
            return
        }
        isDismissed = true
        dismissSubject.send()
    }
    
    open func handle(alert: Alert) {
        state.send(.failure(alert))
    }
}
