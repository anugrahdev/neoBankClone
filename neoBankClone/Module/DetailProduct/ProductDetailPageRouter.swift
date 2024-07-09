//
//  DetailPageRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import Foundation

protocol ProductDetailPageRouterLogic {
    static func assembleModule(with product: NeoProductModel) -> ProductDetailViewController
    func presentPaymentPage(with data: NeoProductDetailSelectionModel)
}

class ProductDetailPageRouter: ProductDetailPageRouterLogic {
    weak var viewController: ProductDetailViewController?

    static func assembleModule(with product: NeoProductModel) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let router = ProductDetailPageRouter()
        
        view.router = router
        view.setProductData(with: product)
        router.viewController = view
        
        return view
    }
    
    func presentPaymentPage(with data: NeoProductDetailSelectionModel) {
        guard let viewController = viewController else {
            return
        }
        
        let paymentViewController = ProductPaymentRouter.assembleModule(with: data)
        viewController.navigationController?.pushViewController(paymentViewController, animated: true)
    }
}
