//
//  NeoProduct.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

struct NeoProductModel: Codable {
    let rate: Int?
    let code: String?
    let marketingPoints: [String]?
    let productName: String?
    let startingAmount: Int?
    let isPopular: Bool?
}

struct NeoProductResponseModel: Codable {
    let data: [NeoProductGroupModel]?
}

struct NeoProductGroupModel: Codable {
    let productList: [NeoProductModel]?
    let productGroupName: String?
}


struct NeoProductWithType {
    let product: NeoProductModel?
    let type: String?
}

private var productTypes = [String: String]()

extension NeoProductModel {
    var type: String {
        get { return productTypes[code ?? ""] ?? "" }
        set { productTypes[code ?? ""] = newValue }
    }
}
