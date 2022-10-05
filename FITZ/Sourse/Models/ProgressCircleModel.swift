//
//  ProgressCircleViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 05.10.2022.
//

import Foundation

struct ProgressCircleModel{
    
    let title: String
    let message: String
    let persentageComplete: Double
    var shouldShowTitle: Bool{
        persentageComplete <= 1
    }
    
}
