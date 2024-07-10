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
        self.apiRequest?.getLandingData { [weak self] (result: RestApiResult<NeoProductResponseModel>) in
            guard let self = self else { return }

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
