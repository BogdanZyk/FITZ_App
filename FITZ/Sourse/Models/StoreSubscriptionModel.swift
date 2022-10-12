//
//  StoreSubscriptionModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 12.10.2022.
//

import StoreKit

struct StoreSubscriptionModel{
    let id: String
    let title: String
    let price: String?
    
    init(product: SKProduct){
        self.id = product.productIdentifier
        self.title = product.localizedTitle
        self.price = product.price.doubleValue.asGBRCurrencyWith2Decimals()
    }
}
