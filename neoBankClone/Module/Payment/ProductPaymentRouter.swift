//
//  ProductPaymentRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import Foundation

class ProductPaymentRouter: ProductPaymentRouterProtocol {
    weak var viewController: ProductPaymentViewController?

    static func assembleModule(with data: NeoProductDetailSelectionModel) -> ProductPaymentViewController {
        let view = ProductPaymentViewController()
        let router = ProductPaymentRouter()
        let interactor = ProductPaymentInteractor()
        let presenter = ProductPaymentPresenter()
        router.viewController = view
        interactor.request = RestApiRequest()
        interactor.delegate = presenter
        view.presenter = presenter
        view.setProductPaymentData(with: data)
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        return view
    }
    
}
