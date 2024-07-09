//
//  PaymentDataModel.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

struct PaymentDataModel: Codable {
    let data: [PaymentMethod]
}

struct PaymentMethod: Codable {
    let paymentMethod: String
    let channels: [Channel]

    enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
        case channels
    }
}

struct Channel: Codable {
    let name: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
    }
}
