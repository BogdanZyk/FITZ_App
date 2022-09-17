//
//  Challenge.swift
//  FITZ
//
//  Created by Bogdan Zykov on 15.09.2022.
//

import Foundation

struct Challenge: Codable, Hashable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let lenght: Int
    let userId: String
    let startDate: Date
}
