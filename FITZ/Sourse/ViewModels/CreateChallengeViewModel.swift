//
//  CreateChallengeViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject{
    @Published var dropdowns: [CallengePartModel] = [
        .init(type: .exercise),
        .init(type: .start),
        .init(type: .increase),
        .init(type: .length)
    ]
    
    
    enum Action{
        case selectOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool{
        selectedSelectedDropdownIndex != nil
    }
    
    var selectedSelectedDropdownIndex: Int?{
        dropdowns.enumerated().first(where: {$0.element.isSelected})?.offset
    }
    
    var displayedOption: [DropdownOption]{
        guard let index = selectedSelectedDropdownIndex else{return []}
        return dropdowns[index].options
    }
    
    func send(_ action: Action){
        switch action {
        case let .selectOption(index):
            guard let selectedSelectedDropdownIndex = selectedSelectedDropdownIndex else{return}
            claerSelectedOptions()
            dropdowns[selectedSelectedDropdownIndex].options[index].isSelected = true
            clearSelectedDopdown()
        }
    }
    
    public func clearIsSelectedAllDropdowns(){
        dropdowns.indices.forEach { index in
            dropdowns[index].isSelected = false
        }
    }
    
    private func claerSelectedOptions(){
        guard let selectedSelectedDropdownIndex = selectedSelectedDropdownIndex else{return}
        dropdowns[selectedSelectedDropdownIndex].options.indices.forEach{ index in
            dropdowns[selectedSelectedDropdownIndex].options[index].isSelected = false
        }
    }
    
    private func clearSelectedDopdown(){
        guard let selectedSelectedDropdownIndex = selectedSelectedDropdownIndex else{return}
        dropdowns[selectedSelectedDropdownIndex].isSelected = false
    }
}


extension CreateChallengeViewModel{

}
