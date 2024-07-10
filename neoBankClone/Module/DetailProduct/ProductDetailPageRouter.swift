//
//  DetailPageRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import Foundation

class ProductDetailPageRouter: ProductDetailPageRouterProtocol {
    weak var viewController: ProductDetailViewController?

    static func assembleModule(with product: NeoProductModel) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let router = ProductDetailPageRouter()
        let presenter = ProductDetailPagePresenter(product: product)

        router.viewController = view
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        return view
    }
    
    func pushPaymentPage(with data: NeoProductDetailSelectionModel) {
        guard let viewController = viewController else {
            return
        }
        
        let paymentViewController = ProductPaymentRouter.assembleModule(with: data)
        viewController.navigationController?.pushViewController(paymentViewController, animated: true)
    }
}
