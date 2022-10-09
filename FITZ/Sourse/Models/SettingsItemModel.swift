//
//  SettingsItemModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI

extension ProfileViewModel{
    
    struct SettingsItemModel {
        let title: String
        let iconName: String
        let type: SettingsItemType
        
        
     
    }

    enum SettingsItemType{
        case mode
        case privacy
        case logout
        case about
    }
    
}

