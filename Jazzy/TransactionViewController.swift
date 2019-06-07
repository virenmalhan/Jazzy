//
//  ViewController.swift
//  Jazzy
//
//  Created by Viren Malhan on 07/06/19.
//  Copyright © 2019 Viren Malhan. All rights reserved.
//

import UIKit

/// This View Controller class is used to initialise any Transaction with in the application.
class TransactionViewController: UIViewController {
    
    /// Transaction object to create any transaction.
    var transaction: Transaction?

    /// This method is called when TransactionViewController is loaded in the memory
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let transactionData = TransactionData(transactionId: "tra_w11244", type: .plans, paymentGatewayType: .razorPay, withDefaultData: true, data: [:])
        transaction = Transaction(transactionData: transactionData, delegate: self)
        transaction?.startTransaction()
    }
}

// MARK: - Delegate Method implementation of TransactionDelegate.
extension TransactionViewController: TransactionDelegate {
    
    func onTransactionSuccess(_ transactionId: String, andData response: [AnyHashable : Any]?) {
        print("Transaction Sucessfull")
    }
    
    func onTransactionError(_ transactionId: String, code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("Transaction failed")
    }
    
    
}

