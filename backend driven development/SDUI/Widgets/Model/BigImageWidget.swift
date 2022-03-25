//
//  BigImageWidget.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit


struct BigImageWidget: Widget {
    let color: String
    let action: AnyAction?
    
    
    func createView(visitor: Visitor) -> UIView {
        visitor.visit(widget: self)
    }
}

