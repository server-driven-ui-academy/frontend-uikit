//
//  Widget.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 09/03/22.
//

import UIKit

protocol Widget: Decodable {
    func createView(visitor: Visitor) -> UIView
}

// Widgets that may receive an Action from backend
// must implement this protocol
protocol Clickable {
    var action: AnyAction? { get }
}
