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
        self.request?.getPaymentData { (result: RestApiResult<PaymentDataModel>) in
            switch result {
            case .success(let data):
                self.delegate?.getPaymentDataDidSuccess(data: data)
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
