//
//  CircleCollectionWidget.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

struct CircleCollectionWidget: Widget {
    struct Item: Decodable, Clickable {
        let color: String
        let text: String
        let action: AnyAction?
    }
    
    let list: [Item]
    
    
    func createView(visitor: Visitor) -> UIView {
        visitor.visit(widget: self)
    }
}
