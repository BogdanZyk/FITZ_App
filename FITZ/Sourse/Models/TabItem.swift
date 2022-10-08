//
//  TabItem.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI


struct TabItem: Hashable{
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType{
        case challengeList
        case settings
    }
}

