//
//  DropdownOptionProtocol.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import Foundation

protocol DropdownOptionProtocol{
    func toDropdownOption(_ isPremium: Bool) -> DropdownOption?
}
