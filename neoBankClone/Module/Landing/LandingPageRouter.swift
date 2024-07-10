//
//  LandingPageRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

class LandingPageRouter: LandingPageRouterProtocol {
    
    weak var viewController: LandingPageViewController?
    
    static func assembleModule() -> LandingPageViewController {
        let view = LandingPageViewController()
        let interactor = LandingPageInteractor()
        let router = LandingPageRouter()
        let presenter = LandingPagePresenter(interactor: interactor, router: router)
        
        interactor.apiRequest = RestApiRequest()
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func presentProductDetailPage(product: NeoProductModel) {
        let detailPage = ProductDetailPageRouter.assembleModule(with: product)
        viewController?.navigationController?.pushViewController(detailPage, animated: true)
    }
    
}
