//
//  ListWidget.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

struct ListWidget: Widget {
    struct Item: Decodable {
        let color: String
        let text: String
    }
    
    let list: [Item]
    
    
    func createView(visitor: Visitor) -> UIView {
        visitor.visit(widget: self)
    }
}
