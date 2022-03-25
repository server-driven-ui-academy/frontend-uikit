//
//  FakeAPI.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 24/03/22.
//

import Foundation

struct FakeAPI {
    static func call<T: Decodable>(endpoint: String,
                                   jsonData: Data? = nil,
                                   model: T.Type,
                                   onSuccess: @escaping (_ dataDecoded: T) -> Void,
                                   onFailure: ((_ response: HTTPURLResponse) -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            let response = Bundle.main.decode(T.self, from: endpoint + ".json")
            
            onSuccess(response)
        }
    }
}
