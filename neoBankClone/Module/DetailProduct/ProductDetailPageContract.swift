//
//  ProductDetailPageContract.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

protocol ProductDetailPagePresenterProtocol: AnyObject {
    func presentPaymentPage(with data: NeoProductDetailSelectionModel)
    func didLoad()
}

protocol ProductDetailPageViewControllerProtocol: AnyObject {
}

protocol ProductDetailPageRouterProtocol: AnyObject {
    static func assembleModule(with product: NeoProductModel) -> ProductDetailViewController
    func pushPaymentPage(with data: NeoProductDetailSelectionModel)
}

protocol ProductDetailPageInteractorProtocol: AnyObject {
    
}

protocol ProductDetailPageInteractorDelegate: AnyObject {
    
}

