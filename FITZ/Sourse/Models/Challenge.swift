//
//  Challenge.swift
//  FITZ
//
//  Created by Bogdan Zykov on 15.09.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Challenge: Codable {
    @DocumentID var id: String?
    let exercise: String
    let startAmount: Int
    let increase: Int
    let lenght: Int
    let userId: String
    let startDate: Date
    let activities: [Activity]
}

struct Activity: Codable{
    let date: Date
    let isComplete: Bool
}
