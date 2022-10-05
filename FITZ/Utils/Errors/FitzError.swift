//
//  FitzError.swift
//  FITZ
//
//  Created by Bogdan Zykov on 15.09.2022.
//

import Foundation


enum FitzError: LocalizedError{
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String?{
        switch self {
        case .auth(let description):
            return description
        case .default(let description):
            return description ?? "Something went wrong"
        }
    }
}
