//
//  ServerUIResponse.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 09/03/22.
//

import Foundation

struct ServerUIResponse: Decodable {
    private enum CodingKeys: CodingKey {
        case widgets
    }

    let widgets: [Widget]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.widgets = try container.decode([AnyWidget].self, forKey: .widgets).compactMap { $0.widget }
    }

    init(widgets: [Widget]) {
        self.widgets = widgets
    }
}
