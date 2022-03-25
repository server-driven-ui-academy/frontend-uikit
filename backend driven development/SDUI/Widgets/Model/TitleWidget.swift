//
//  TitleWidget.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit


struct TitleWidget: Widget {
    let title: String
    
    
    func createView(visitor: Visitor) -> UIView {
        visitor.visit(widget: self)
    }
}

