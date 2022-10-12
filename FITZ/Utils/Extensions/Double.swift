//
//  Double.swift
//  FITZ
//
//  Created by Bogdan Zykov on 12.10.2022.
//

import Foundation




extension Double{
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //formatter.locale = .current // <- default value
        //        formatter.currencyCode = "gbr" // <- change currency
        //        formatter.currencySymbol = "£" // <- change currency symbol
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asGBRCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return  "£" + (currencyFormatter2.string(from: number) ?? "0")
    }
    
    
}
