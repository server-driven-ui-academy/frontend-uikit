//
//  BannerWidget.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

struct BannerWidget: Widget, Clickable {
    let imageURLString: String
    let color: String
    let title: String
    let titleColor: String?
    let action: AnyAction?
    
    
    func createView(visitor: Visitor) -> UIView {
        visitor.visit(widget: self)
    }
}
