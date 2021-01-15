//
//  Extensions+BaseViewModel.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 01/10/21.
//

import Foundation
import URENCore

extension BaseViewModel {
    func handle(error: Error) {
        print("*RESPONSE FAILURE: \(error.localizedDescription)")
        
        let actions = [AlertAction(title: Localizer.ok.localized)]
        let alert = AnyAlert(title: Localizer.error.localized,
                             message: error.localizedDescription,
                             actions: actions)
        handle(alert: alert)
    }
}
