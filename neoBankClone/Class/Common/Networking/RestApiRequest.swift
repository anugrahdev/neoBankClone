//
//  HTTPRequest.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

struct RestApiRequest: RestApiInputProtocol {
    func getLandingData<T: Codable>(completion: @escaping CompletionHandler<T>) {
        let url = AppConstants.mockAPIURL
        let params: [String: Any] = [:]
        RestApiServices.shared.request(url: url, params: params, completion: completion)
    }
    
    func getPaymentData<T>(completion: @escaping CompletionHandler<T>) where T : Decodable, T : Encodable {
        let paymentJson = AppConstants.mockPaymentJSON
        JSONDecoderHelper.shared.decode(from: paymentJson, to: T.self, completion: completion)
    }
}
