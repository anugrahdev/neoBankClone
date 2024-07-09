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
        let interactor = ProductPaymentInteractor()
        var presenter = ProductPaymentPresenter()
        interactor.request = RestApiRequest()
        presenter.view = view
        view.interactor = interactor
        view.router = router
        view.setProductPaymentData(with: data)
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
}
