//
//  CallengePartModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import Foundation


struct CallengePartModel: DropdownItemProtocol{
    var ortions: [DropdownOption]
    var headerTitle: String {
        type.rawValue
    }
    var dropdownTitle: String {
        ortions.first(where: {$0.isSelected})?.formatted ?? ""
    }
    var isSelected: Bool = false
    
    private let type: ChallengePartType
    
    init(type: ChallengePartType){
        
        
        switch type {
        case .exercise:
            self.ortions = ExerciseOption.allCases.map({$0.toDropdownOption})
        case .start:
            self.ortions = StartOption.allCases.map({$0.toDropdownOption})
        case .increase:
            self.ortions = IncreaseOption.allCases.map({$0.toDropdownOption})
        case .length:
            self.ortions = LenghtOption.allCases.map({$0.toDropdownOption})
        }
        
        self.type = type
    }
    
    enum ChallengePartType: String, CaseIterable{
        case exercise = "Exercise"
        case start = "Starting Amount"
        case increase = "Daily Increase"
        case length = "Challenge Lenght"
    }
    enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol{
        case pullups
        case pushups
        case situps
        
        var toDropdownOption: DropdownOption {
            .init(type: .text(rawValue), formatted: rawValue.capitalized, isSelected: self == .pullups)
        }
    }
    
    enum StartOption: Int, CaseIterable, DropdownOptionProtocol{
        case one = 1, two, three, four, five
        
        var toDropdownOption: DropdownOption {
            .init(type: .number(rawValue), formatted: "\(rawValue)", isSelected: self == .one)
        }
    }
    
    enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol{
        case one = 1, two, three, four, five
        
        var toDropdownOption: DropdownOption {
            .init(type: .number(rawValue), formatted: "+\(rawValue)", isSelected: self == .one)
        }
    }
    enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol{
        case saven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
        
        var toDropdownOption: DropdownOption {
            .init(type: .number(rawValue), formatted: "\(rawValue) days", isSelected: self == .saven)
        }
    }
    
    
}
