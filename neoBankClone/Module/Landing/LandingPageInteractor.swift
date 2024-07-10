//
//  LandingPageInteractor.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

class LandingPageInteractor: LandingPageInteractorProtocol {
    
    var apiRequest: RestApiInputProtocol?
    var presenter: LandingPageInteractorDelegate?

    func fetchLandingData() {
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
