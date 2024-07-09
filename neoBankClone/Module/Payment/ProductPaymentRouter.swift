//
//  ProductPaymentRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import Foundation

protocol ProductPaymentRouterLogic {
    static func assembleModule(with data: NeoProductDetailSelectionModel) -> ProductPaymentViewController
}

class ProductPaymentRouter: ProductPaymentRouterLogic {
    weak var viewController: ProductPaymentViewController?

    static func assembleModule(with data: NeoProductDetailSelectionModel) -> ProductPaymentViewController {
        let view = ProductPaymentViewController()
        let router = ProductPaymentRouter()
        view.router = router
        return view
    }
    
}
