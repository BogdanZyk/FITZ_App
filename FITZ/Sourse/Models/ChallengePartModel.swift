//
//  ChallengePartModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import Foundation


struct ChallengePartModel: DropdownItemProtocol{
    
    var isSelected: Bool = false
    
    var selectedOption: DropdownOption
    
    var options: [DropdownOption]
    var headerTitle: String {
        type.rawValue
    }
    var dropdownTitle: String {
        selectedOption.formatted
    }
    
    private let type: ChallengePartType
    
    init(type: ChallengePartType){
        
        
        switch type {
        case .exercise:
            self.options = ExerciseOption.allCases.map({$0.toDropdownOption})
        case .start:
            self.options = StartOption.allCases.map({$0.toDropdownOption})
        case .increase:
            self.options = IncreaseOption.allCases.map({$0.toDropdownOption})
        case .length:
            self.options = LenghtOption.allCases.map({$0.toDropdownOption})
        }
        
        self.type = type
        self.selectedOption = options.first!
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
            .init(type: .text(rawValue), formatted: rawValue.capitalized)
        }
    }
    
    enum StartOption: Int, CaseIterable, DropdownOptionProtocol{
        case one = 1, two, three, four, five
        
        var toDropdownOption: DropdownOption {
            .init(type: .number(rawValue), formatted: "\(rawValue)")
        }
    }
    
    enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol{
        case one = 1, two, three, four, five
        
        var toDropdownOption: DropdownOption {
            .init(type: .number(rawValue), formatted: "+\(rawValue)")
        }
    }
    enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol{
        case saven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
        
        var toDropdownOption: DropdownOption {
            .init(type: .number(rawValue), formatted: "\(rawValue) days")
        }
    }
    
    
}


extension ChallengePartModel{
    var text: String?{
        if case let .text(text) = selectedOption.type{
            return text
        }
        return nil
    }
    
    var number: Int?{
        if case let .number(number) = selectedOption.type{
            return number
        }
        return nil
    }
}
