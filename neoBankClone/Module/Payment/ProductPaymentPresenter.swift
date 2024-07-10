//
//  ProductPaymentPresenter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

class ProductPaymentPresenter: ProductPaymentPresenterProtocol {
    
    weak var view: ProductPaymentViewController?
    var interactor: ProductPaymentInteractorProtocol?
    var router: ProductPaymentRouterProtocol?

    func presentPaymentData(data: PaymentDataModel) {
        view?.setPaymentListData(with: data)
    }
    
    func getPaymentData() {
        interactor?.fetchPaymentData()
    }
}

extension ProductPaymentPresenter: ProductPaymentInteractorDelegate {
    func getPaymentDataDidSuccess(data: PaymentDataModel) {
        view?.setPaymentListData(with: data)
    }
}
