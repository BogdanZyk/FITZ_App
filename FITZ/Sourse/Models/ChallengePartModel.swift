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
    
    init(type: ChallengePartType, isPremium: Bool = false){
        
        
        switch type {
        case .exercise:
        self.options = ExerciseOption.allCases.compactMap({$0.toDropdownOption(isPremium)})
        case .start:
            self.options = StartOption.allCases.compactMap({$0.toDropdownOption(isPremium)})
        case .increase:
            self.options = IncreaseOption.allCases.compactMap({$0.toDropdownOption(isPremium)})
        case .length:
            self.options = LenghtOption.allCases.compactMap({$0.toDropdownOption(isPremium)})
        }
        
        self.type = type
        self.selectedOption = options.first!
    }
    
    mutating func setCustomExerciseOption(_ text: String){
        let customOption: DropdownOption = .init(type: .text(text), formatted: text.capitalized)
        self.options.append(customOption)
        self.selectedOption = customOption
    }
    
    enum ChallengePartType: String, CaseIterable{
        case exercise = "Exercise"
        case start = "Starting Amount"
        case increase = "Daily Increase"
        case length = "Challenge Lenght"
    }
    
    enum ExerciseOption: String, CaseIterable{
        case pullups
        case pushups
        case situps
        case pressups
        case dips
        
        func toDropdownOption(_ isPremium: Bool) -> DropdownOption? {

            if isPremium{
               return .init(type: .text(rawValue), formatted: rawValue.capitalized)
            }else{
                switch self{
                case .pullups, .pushups, .situps:
                    return .init(type: .text(rawValue), formatted: rawValue.capitalized)
                default:
                    return nil
                }
            }
        }
    }
    
    enum StartOption: Int, CaseIterable, DropdownOptionProtocol{
        
        case one = 1, two, three, four, five, six, seven, eight, nine, ten
        
        func toDropdownOption(_ isPremium: Bool) -> DropdownOption? {
            if isPremium{
               return .init(type: .number(rawValue), formatted: "\(rawValue)")
            }else{
                switch self{
                case .one, .two, .three, .four, .five:
                    return .init(type: .number(rawValue), formatted: "\(rawValue)")
                default:
                    return nil
                }
            }
        }
    }
    
    enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol{
        case one = 1, two, three, four, five, six, seven, eight, nine, ten
        
        func toDropdownOption(_ isPremium: Bool) -> DropdownOption? {
            if isPremium{
               return .init(type: .number(rawValue), formatted: "\(rawValue)")
            }else{
                switch self{
                case .one, .two, .three, .four, .five:
                    return .init(type: .number(rawValue), formatted: "\(rawValue)")
                default:
                    return nil
                }
            }
        }
    }
    
    enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol{
        case saven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28, thirtyFive = 35, fortyTwo = 42
        
        func toDropdownOption(_ isPremium: Bool) -> DropdownOption? {
            if isPremium{
               return .init(type: .number(rawValue), formatted: "\(rawValue)")
            }else{
                switch self{
                case .saven, .fourteen:
                    return .init(type: .number(rawValue), formatted: "\(rawValue)")
                default:
                    return nil
                }
            }
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
