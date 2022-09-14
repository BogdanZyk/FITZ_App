//
//  CreateChallengeViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//
import Combine
import SwiftUI



final class CreateChallengeViewModel: ObservableObject{
    
    typealias UserId = String
    
    private let userServise: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userServise: UserServiceProtocol = UserService()){
        self.userServise = userServise
    }
    
    @Published var dropdowns: [CallengePartModel] = [
        .init(type: .exercise),
        .init(type: .start),
        .init(type: .increase),
        .init(type: .length)
    ]
    
    
    enum Action{
        case selectOption(index: Int)
        case createChallenge
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
        case .createChallenge:
            currentUserId().sink { completion in
                switch completion{
                case .finished:
                    print("completion")
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { userId in
                print("user id", userId)
            }
            .store(in: &cancellables)

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
    
    private func currentUserId() ->AnyPublisher<UserId, Error>{
        print("Get user id")
        return userServise.currentUser().flatMap{ user -> AnyPublisher<UserId, Error> in
            if let userId = user?.uid{
                print("userId", userId)
                return Just(userId).setFailureType(to: Error.self).eraseToAnyPublisher()
            }else{
                print("user is inAnonymously")
              return self.userServise.signInAnonymously()
                    .map({$0.uid})
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}


extension CreateChallengeViewModel{

}
