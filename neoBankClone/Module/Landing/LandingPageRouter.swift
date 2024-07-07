//
//  LandingPageRouter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

protocol LandingPageRouterLogic {
    static func assembleModule() -> LandingPageViewController
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
//        view.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
}
