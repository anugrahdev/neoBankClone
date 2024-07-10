//
//  ProductPaymentContract.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import Foundation

protocol ProductPaymentPresenterProtocol: AnyObject {
    func getPaymentData()
}

protocol ProductPaymentViewControllerProtocol: AnyObject {
    func setProductPaymentData(with data: NeoProductDetailSelectionModel)
    func setPaymentListData(with data: PaymentDataModel)
}

protocol ProductPaymentRouterProtocol: AnyObject {
    static func assembleModule(with data: NeoProductDetailSelectionModel) -> ProductPaymentViewController
}

protocol ProductPaymentInteractorProtocol: AnyObject {
  func fetchPaymentData()
}

protocol ProductPaymentInteractorDelegate: AnyObject {
  func getPaymentDataDidSuccess(data: PaymentDataModel)
}

