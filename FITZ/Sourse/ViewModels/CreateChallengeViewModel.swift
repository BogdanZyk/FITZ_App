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
    
//    @Published var dropdowns: [CallengePartModel] = [
//        .init(type: .exercise),
//        .init(type: .start),
//        .init(type: .increase),
//        .init(type: .length)
//    ]
    
    @Published var exerciseDropdowns = CallengePartModel(type: .exercise)
    @Published var startDropdowns = CallengePartModel(type: .start)
    @Published var increaseDropdowns = CallengePartModel(type: .increase)
    @Published var lengthDropdowns = CallengePartModel(type: .length)
    
    
    enum Action{
        case createChallenge
    }
    

    
    func send(_ action: Action){
        
        switch action {
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
