//
//  ProductPaymentInteractor.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

protocol ProductPaymentInteractorLogic: AnyObject {
  func getPaymentData()
}

class ProductPaymentInteractor: ProductPaymentInteractorLogic {
    
    var request: RestApiInputProtocol?
    var presenter: ProductPaymentPresenterLogic?

    func getPaymentData() {
        self.request?.getPaymentData { (result: RestApiResult<PaymentDataModel>) in
            switch result {
            case .success(let data):
                self.presenter?.presentPaymentData(data: data)
            case .error(let error):
                // Handle the error case
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
