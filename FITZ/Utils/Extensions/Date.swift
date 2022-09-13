//
//  Date.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 21.08.2022.
//

import Foundation


extension DateComponentsFormatter{
    
    static let positional: DateComponentsFormatter = {
       let formatter = DateComponentsFormatter()
        formatter.allowedUnits =  [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
}
