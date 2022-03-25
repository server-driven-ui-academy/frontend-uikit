//
//  AnyAction.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 09/03/22.
//

import Foundation

final class AnyAction: Decodable {

    private enum CodingKeys: CodingKey {
        case identifier
    }

    let action: Action?

    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(ActionIdentifier.self, forKey: .identifier)
            self.action = try type.metatype.init(from: decoder)
        } catch {
            self.action = nil
        }
    }
}
