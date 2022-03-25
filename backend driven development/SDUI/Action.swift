//
//  Action.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 09/03/22.
//

import UIKit

protocol Action: Decodable {
    func scene() -> UIViewController
}
