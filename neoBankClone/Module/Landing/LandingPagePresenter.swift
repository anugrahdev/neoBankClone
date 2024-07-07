//
//  LandingPagePresenter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

protocol LandingPagePresenterLogic {
    func presentLandingData(data: NeoProductResponseModel)
}

struct LandingPagePresenter: LandingPagePresenterLogic {
    
    weak var view: LandingPageViewControllerLogic?

    func presentLandingData(data: NeoProductResponseModel) {
        var products: [NeoProductWithType] = []
        for group in data.data ?? [] {
            for product in group.productList ?? [] {
                products.append(NeoProductWithType(product: product, type: group.productGroupName))
            }
        }
        view?.presentLandingData(products: products)
    }
}
