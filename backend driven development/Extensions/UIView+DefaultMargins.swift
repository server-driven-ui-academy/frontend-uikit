//
//  UIView+DefaultMargins.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 17/03/22.
//

import UIKit

extension UIView {
    func useDefaultLayoutMargins() {
        self.layoutMargins = UIView.getDefaultLayoutMargins()
    }
    
    static func getDefaultLayoutMargins() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
