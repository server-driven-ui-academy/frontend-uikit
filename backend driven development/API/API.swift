//
//  API.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 24/03/22.
//

import Foundation

struct API {
    static let baseURL = "http://localhost:5001/uikit/"
    
    static func call<T: Decodable>(endpoint: String,
                                   jsonData: Data? = nil,
                                   model: T.Type,
                                   onSuccess: @escaping (_ dataDecoded: T) -> Void,
                                   onFailure: ((_ response: HTTPURLResponse) -> Void)? = nil) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 || response.statusCode == 201 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let dataDecoded = try JSONDecoder().decode(model, from: data)
                        onSuccess(dataDecoded)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else {
                if let onFailure = onFailure {
                    DispatchQueue.main.async {
                        onFailure(response)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
