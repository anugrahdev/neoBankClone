//
//  LandingPageContract.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 10/07/24.
//

import Foundation

protocol LandingPagePresenterProtocol: AnyObject {
    func getLandingData()
    func presentDetailData(products: NeoProductModel)
}

protocol LandingPageViewControllerProtocol: AnyObject {
    func presentLandingData(products: [NeoProductWithType])
}

protocol LandingPageRouterProtocol: AnyObject {
    static func assembleModule() -> LandingPageViewController
    func presentProductDetailPage(product: NeoProductModel)
}

protocol LandingPageInteractorProtocol: AnyObject {
    func fetchLandingData()
}

protocol LandingPageInteractorDelegate: AnyObject {
    func presentLandingData(data: NeoProductResponseModel)
}

