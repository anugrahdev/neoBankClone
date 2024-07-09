//
//  ProductPaymentPresenter.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

protocol ProductPaymentPresenterLogic {
    func presentPaymentData(data: PaymentDataModel)
}

struct ProductPaymentPresenter: ProductPaymentPresenterLogic {
    
    weak var view: ProductPaymentViewControllerProtocol?

    func presentPaymentData(data: PaymentDataModel) {
        view?.setPaymentListData(with: data)
    }
}
