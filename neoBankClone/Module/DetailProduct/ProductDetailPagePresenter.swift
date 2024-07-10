//
//  DetailPagePresenter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import Foundation

class ProductDetailPagePresenter: ProductDetailPagePresenterProtocol {
    
    weak var view: ProductDetailViewController?
    var router: ProductDetailPageRouterProtocol?
    let product: NeoProductModel

    init(product: NeoProductModel) {
        self.product = product
    }
    
    func presentPaymentPage(with data: NeoProductDetailSelectionModel) {
        router?.pushPaymentPage(with: data)
    }
    
    func didLoad() {
        view?.product = product
    }
}
