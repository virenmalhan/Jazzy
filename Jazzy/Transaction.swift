//
//  Transaction.swift
//  Jazzy
//
//  Created by Viren Malhan on 02/05/19.
//  Copyright © 2019 Viren Malhan. All rights reserved.
//

import Foundation

// MARK:- Enum

/// This enum tells the type of transaction, which is passed in TransactionData.
///
/// - shop: Transaction is instantiated for shop.
/// - plans: Transaction is instantiated for plan subscription.
enum TransactionType {
    case shop
    case plans
}

/// This enum gives payment gateway type, passed in TransactionData.
///
/// - razorPay: For Razor Pay gateway.
/// - payU: For PayU gateway.
/// - stripe: For Stripe gateway.
enum PaymentGatewayType {
    case razorPay
    case payU
    case stripe
}

/// This have all the keys which has to passed in TransactionData. Add the key in enum if its not there. this will be used for all gateway type.
///
/// - amount: amount used in razor pay
/// - name: name used in razor pay
/// - description: description used in razor pay
/// - prefill: prefill used in razor pay
/// - contact: contact used in razor pay
/// - email: email used in razor pay
/// - notes: notes used in razor pay
/// - draftOrderId: draftOrderId used in razor pay
/// - theme: theme used in razor pay
/// - color: color used in razor pay
enum TransactionDataKey: String {
    case amount = "amount"
    case name = "name"
    case description = "description"
    case prefill = "prefill"
    case contact = "contact"
    case email = "email"
    case notes = "notes"
    case draftOrderId = "draft_order_id"
    case theme = "theme"
    case color = "color"
}

// MARK:- Protocol

/// This protocol is used to start and stop Transaction. Don't use it directly in view controller. use Transaction instead.
fileprivate protocol Transactionable {
    
    /// This function is used to start Transaction.
    func startTransaction()
    
    /// This function is used to stop Transaction.
    func stopTransaction()
}

/// This protocol is used to get Transaction call backs. Use this in View controller.
protocol TransactionDelegate {
    
    /// Callback method on successfull transaction.
    ///
    /// - Parameters:
    ///   - transactionId: transaction id from api.
    ///   - response: response dictionary from payment gateway.
    func onTransactionSuccess(_ transactionId: String, andData response: [AnyHashable : Any]?)
    
    /// Callback method on transaction failure.
    ///
    /// - Parameters:
    ///   - transactionId: transaction id from  preparam api.
    ///   - code: error code
    ///   - str: error description
    ///   - response: response dictionary from payment gateway.
    func onTransactionError(_ transactionId: String, code: Int32, description str: String, andData response: [AnyHashable : Any]?)
}

// MARK:- Struct

/// All payment related transaction should be created through Transaction.
struct Transaction: Transactionable {
    
    // MARK:- Properties
    
    /// TransactionData is used to keep all transaction related data.
    var transactionData: TransactionData
    
     // MARK:- Methods
    
    /// This method starts transaction.
    func startTransaction() {
        
    }
    
    /// This method starts transaction.
    func stopTransaction() {
        
    }
    
    /// Initialiser for Transaction
    ///
    /// - Parameters:
    ///   - transactionData: Inject TransactionData
    ///   - delegate: delegate for VC.
    init(transactionData: TransactionData, delegate: TransactionDelegate) {
        self.transactionData = transactionData
        
    }
}

// MARK:- Struct

/// This holds transaction related data, with transaction type and gateway.
struct TransactionData {
    
    // MARK:- Properties
    
    /// transaction id from api.
    let transId: String
    
    /// Gateway api key
    let apiKey: String?
    
    /// TransactionType passedn in TransactionData
    let transactionType: TransactionType
    
    /// PaymentGatewayType passedn in TransactionData
    let gatewayType: PaymentGatewayType
    
    /// transaction data dictionary.
    /// Note: - this dictionary holds data required for payment gateway.
    var paymentGatewayDictionary: [String: Any]
    
    // MARK:- Methods
    
    /// initialiser for TransactionData
    ///
    /// - Parameters:
    ///   - key: optional parameter if backend is sending api key in paymentGatewayDictionary. no need to send it.
    ///   - transactionId: transaction id from  preparam api.
    ///   - type: TransactionType
    ///   - paymentGatewayType: PaymentGatewayType
    ///   - isRec: flag to set transaction as recurring
    ///   - withDefaultData: flag to initialise with default data.
    ///   - data: pass the data if you don't want default initialiser to work.
    ///   - hitChargeAPI: flag to hit charge api after successfull payment.
    /// Note: - this works only when withDefaultData is set to true.
    init(key: String? = nil, transactionId: String, type: TransactionType, paymentGatewayType: PaymentGatewayType, withDefaultData: Bool = true, data: [String: Any] = [String: Any]()) {
        apiKey = key
        transId = transactionId
        transactionType = type
        gatewayType = paymentGatewayType
        paymentGatewayDictionary = withDefaultData ? TransactionData.getDefaultData(gateway: paymentGatewayType) : data
    }

    /// This method is used to get default data for payment gateway. only common data which is not user selection specific show be considered in default data.
    ///
    /// - Parameter gateway: pass gateway enum to get default data for enum
    /// - Returns: return default data required for TransactionData based on payment gateway.
    static func getDefaultData(gateway: PaymentGatewayType) -> [String: Any] {
        var data: [String: Any] = [String: Any]()
        switch gateway {
        case .razorPay:
            data = [
                TransactionDataKey.name.rawValue: "Viren Malhan",
                TransactionDataKey.description.rawValue: "virenmlahan.vm@gmail.com",
                TransactionDataKey.prefill.rawValue: [
                    TransactionDataKey.contact.rawValue: "",
                    TransactionDataKey.email.rawValue: "virenmlahan.vm@gmail.com",
                    ],
                TransactionDataKey.theme.rawValue: [
                    TransactionDataKey.color.rawValue: "#8BC249"
                    ]
                ]
        default:
            break
        }
        return data
    }
    
    /// This method mutate transaction data. use this method to add data in transactionData.
    ///
    /// - Parameters:
    ///   - key: ""TransactionDataKey
    ///   - value: value for key.
    mutating func addData(key: TransactionDataKey, value: Any) {
        paymentGatewayDictionary[key.rawValue] = value
    }
    
    /// This method mutate transaction data. use this method to add data in nested dictionary in transactionData.
    ///
    /// - Parameters:
    ///   - parentKey: parent key
    ///   - subKey: sub key
    ///   - value: value for key.
    mutating func addSubDictionary(parentKey: TransactionDataKey, subKey: TransactionDataKey, value: Any) {
        if var dict = paymentGatewayDictionary[parentKey.rawValue] as? [String: Any] {
            dict[subKey.rawValue] = value
            paymentGatewayDictionary[parentKey.rawValue] = dict
        } else {
            paymentGatewayDictionary[parentKey.rawValue] = [subKey.rawValue : value]
        }
    }
}
