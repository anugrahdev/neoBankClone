//
//  LandingPageRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

protocol LandingPageRouterLogic {
    static func assembleModule() -> LandingPageViewController
    func presentProductDetailPage(product: NeoProductModel)
}

class LandingPageRouter: LandingPageRouterLogic {
    
    weak var viewController: LandingPageViewController?
    
    static func assembleModule() -> LandingPageViewController {
        let view = LandingPageViewController()
        let interactor = LandingPageInteractor()
        var presenter = LandingPagePresenter()
        let router = LandingPageRouter()
        
        interactor.apiRequest = RestApiRequest()
        presenter.view = view
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func presentProductDetailPage(product: NeoProductModel) {
        let detailPage = ProductDetailPageRouter.assembleModule(with: product)
        viewController?.navigationController?.pushViewController(detailPage, animated: true)
    }
    
}
