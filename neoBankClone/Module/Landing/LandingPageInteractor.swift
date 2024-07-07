//
//  LandingPageInteractor.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation


protocol LandingPageInteractorLogic: AnyObject {
  func getLandingData()
}

class LandingPageInteractor: LandingPageInteractorLogic {
    
    var apiRequest: RestApiInputProtocol?
    var presenter: LandingPagePresenterLogic?

    func getLandingData() {
        self.apiRequest?.getLandingData { (result: RestApiResult<NeoProductResponseModel>) in
            switch result {
            case .success(let data):
                self.presenter?.presentLandingData(data: data)
            case .error(let error):
                // Handle the error case
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
