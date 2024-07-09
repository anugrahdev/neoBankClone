//
//  JSONDecoder.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

struct JSONDecoderHelper {
    
    static let shared: JSONDecoderHelper = {
        JSONDecoderHelper()
    }()
    
    func decode<T: Decodable>(from filename: String, to type: T.Type, completion: @escaping CompletionHandler<T>) {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
                completion(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "File not found"])))
                return
            }

            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.error(error))
                }
            }
        }
    }
}
