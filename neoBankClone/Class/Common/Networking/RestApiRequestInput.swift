//
//  HTTPRequestInput.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

protocol RestApiInputProtocol {
    func getLandingData<T: Codable>(completion: @escaping CompletionHandler<T>)
}
