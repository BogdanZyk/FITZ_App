//
//  StoreViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 12.10.2022.
//
import SwiftUI
import StoreKit

typealias FetchProductsCompletionHandler = (([SKProduct]) -> Void)
typealias PurchaseCompletionHandler = ((SKPaymentTransaction?) -> Void)


final class StoreViewModel: NSObject, ObservableObject{
    
    @Published var allSubscriptions = [StoreSubscriptionModel]()
    
    //Only fot test! needed server side to chek this!
    @AppStorage("isPremium") var isPremium = false
    
    private let allSubscriptionIdentifiers = Set([
    
        "com.BogdanZykov.FITZ.mothly",
        "com.BogdanZykov.FITZ.annually"
    
    ])
    private var completedPurchases = [String]()
    private var productsRequest: SKProductsRequest?
    private var fetchProducts = [SKProduct]()
    private var fetchCompletionHandler: FetchProductsCompletionHandler?
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    
    override init() {
        
        super.init()
        
        startObservingPaymentQueue()
        fetchProducts { products in
            self.allSubscriptions = products.map({.init(product: $0)})
        }
    }
    
    private func startObservingPaymentQueue(){
        SKPaymentQueue.default().add(self)
    }
    
    private func fetchProducts(_ completion: @escaping FetchProductsCompletionHandler){
        guard self.productsRequest == nil else {return}
        fetchCompletionHandler = completion
        productsRequest = SKProductsRequest(productIdentifiers: allSubscriptionIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    private func buy(_ product: SKProduct, completion: @escaping PurchaseCompletionHandler){
        purchaseCompletionHandler = completion
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension StoreViewModel: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            
            var shouldFininshTransaction = false
            
            switch transaction.transactionState{

            case .purchased, .restored:
                completedPurchases.append(transaction.payment.productIdentifier)
                shouldFininshTransaction = true
            case .failed:
                shouldFininshTransaction = false
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
            if shouldFininshTransaction{
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.purchaseCompletionHandler?(transaction)
                    self.purchaseCompletionHandler = nil
                }
            }
        }
    }
}


extension StoreViewModel: SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
        let invalidProducts = response.invalidProductIdentifiers
        guard !loadedProducts.isEmpty else {
            print("Could not load products")
            if !invalidProducts.isEmpty{
                print("Invalid products found: \(invalidProducts)")
            }
            productsRequest = nil
            return
        }
        
        fetchProducts = loadedProducts
        DispatchQueue.main.async {
            self.fetchCompletionHandler?(loadedProducts)
            self.fetchCompletionHandler = nil
            self.productsRequest = nil
        }
        
    }
}


extension StoreViewModel{
    func purchaseProduct(_ subscriptionProduct: StoreSubscriptionModel, completion: @escaping () -> Void){
        guard let product = self.fetchProducts.first(where: {$0.productIdentifier == subscriptionProduct.id}) else {return}
        startObservingPaymentQueue()
        
        buy(product) { _ in
            self.isPremium = true
            completion()
        }
    }
    func restorePurchese(){
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
