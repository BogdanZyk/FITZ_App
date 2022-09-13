//
//  DropdownItemProtocol.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import Foundation

protocol DropdownItemProtocol{
    var options: [DropdownOption] { get }
    var headerTitle: String { get }
    var dropdownTitle: String { get }
    var isSelected: Bool { get set }
}

struct DropdownOption{
    enum DropdownOptionType{
        case text(String)
        case number(Int)
    }
    let type: DropdownOptionType
    
    let formatted: String
    
    var isSelected: Bool
}
