//
//  RestApiServices.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

typealias CompletionHandler<T> = (RestApiResult<T>) -> Void

enum RestApiResult<T> {
    case success(T)
    case error(Error)
}

class RestApiServices {

    static let shared: RestApiServices = {
        RestApiServices()
    }()
    
    func request<T: Codable>(url: String, params: [String: Any], completion: @escaping CompletionHandler<T>) {
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(.error(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<400).contains(httpResponse.statusCode) else {
                let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                completion(.error(customError))
                return
            }
            
            guard let data = data else {
                let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.error(customError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.error(error))
            }
        }
        task.resume()
    }
}
