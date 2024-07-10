//
//  LandingPagePresenter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

class LandingPagePresenter: LandingPagePresenterProtocol {
    weak var view: LandingPageViewController?
    let interactor: LandingPageInteractorProtocol?
    let router: LandingPageRouterProtocol?
    
    func getLandingData() {
        interactor?.fetchLandingData()
    }
    
    init(view: LandingPageViewController? = nil, interactor: LandingPageInteractorProtocol?, router: LandingPageRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func presentDetailData(products: NeoProductModel) {
        router?.presentProductDetailPage(product: products)
    }
}

extension LandingPagePresenter: LandingPageInteractorDelegate {
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
