//
//  CreateChallengeViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//
import Combine
import SwiftUI

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject{
    
   
    private let userServise: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        userServise: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ){
        self.userServise = userServise
        self.challengeService = challengeService
    }
    
    @Published var exerciseDropdowns = CallengePartModel(type: .exercise)
    @Published var startDropdowns = CallengePartModel(type: .start)
    @Published var increaseDropdowns = CallengePartModel(type: .increase)
    @Published var lengthDropdowns = CallengePartModel(type: .length)
    
    @Published var error: FitzError?
    @Published var isLoading: Bool = false
    
    enum Action{
        case createChallenge
    }
    

    
    func send(_ action: Action){
        
        switch action {
        case .createChallenge:
            isLoading = true
            currentUserId().flatMap { userId -> AnyPublisher<Void, FitzError> in
                return self.createChallenge(userId: userId)
            }
            .sink { completion in
                self.isLoading = false
                switch completion{
                case .finished:
                    print("finished")
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { _ in
                print("success")
            }
            .store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, FitzError>{
        guard let exercise = exerciseDropdowns.text,
              let startAmount = startDropdowns.number,
              let increase = increaseDropdowns.number,
              let lenght = lengthDropdowns.number else {
            return Fail(error: .default()).eraseToAnyPublisher()
        }
        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            lenght: lenght,
            userId: userId,
            startDate: Date())
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    
    private func currentUserId() -> AnyPublisher<UserId, FitzError>{
        print("Get user id")
        return userServise.currentUser().flatMap{ user -> AnyPublisher<UserId, FitzError> in
            if let userId = user?.uid{
                print("userId", userId)
                return Just(userId).setFailureType(to: FitzError.self).eraseToAnyPublisher()
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
