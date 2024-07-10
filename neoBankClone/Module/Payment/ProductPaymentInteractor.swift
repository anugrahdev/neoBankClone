//
//  ProductPaymentInteractor.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

class ProductPaymentInteractor: ProductPaymentInteractorProtocol {
    
    var request: RestApiInputProtocol?
    var delegate: ProductPaymentInteractorDelegate?

    func fetchPaymentData() {
        self.request?.getPaymentData { [weak self] (result: RestApiResult<PaymentDataModel>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.getPaymentDataDidSuccess(data: data)
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
