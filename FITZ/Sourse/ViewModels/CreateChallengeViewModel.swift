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
        let isPremium = userServise.isPremium
        self.exerciseDropdowns = ChallengePartModel(type: .exercise, isPremium: isPremium)
        self.startDropdowns = ChallengePartModel(type: .start, isPremium: isPremium)
        self.increaseDropdowns = ChallengePartModel(type: .increase, isPremium: isPremium)
        self.lengthDropdowns = ChallengePartModel(type: .length, isPremium: isPremium)
    }
    
    @Published var exerciseDropdowns: ChallengePartModel
    @Published var startDropdowns: ChallengePartModel
    @Published var increaseDropdowns: ChallengePartModel
    @Published var lengthDropdowns: ChallengePartModel
    @Published var customExerciseText = ""
    
    @Published var error: FitzError?
    @Published var isLoading: Bool = false
    
    enum Action{
        case createChallenge, setCustomExercise
    }


    
    func send(_ action: Action){
        
        switch action {
        case .createChallenge:
            isLoading = true
            currentUserId().flatMap { [weak self] userId -> AnyPublisher<Void, FitzError> in
                guard let self = self else {return Fail(error: .default()).eraseToAnyPublisher()}
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
        case .setCustomExercise:
            if !customExerciseText.isEmpty{
                exerciseDropdowns.setCustomExerciseOption(customExerciseText)
            }
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, FitzError>{
        guard let exercise = exerciseDropdowns.text,
              let startAmount = startDropdowns.number,
              let increase = increaseDropdowns.number,
              let lenght = lengthDropdowns.number else {
            return Fail(error: .default()).eraseToAnyPublisher()
        }
        let startDate = Calendar.current.startOfDay(for: Date())
        
        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            lenght: lenght,
            userId: userId,
            startDate: startDate,
            activities: (0..<lenght).compactMap({ dayNumber in
                if let dateForDayNumber = Calendar.current.date(byAdding: .day, value: dayNumber, to: startDate){
                    return .init(date: dateForDayNumber, isComplete: false)
                }else{
                    return nil
                }
            })
        )
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    
    private func currentUserId() -> AnyPublisher<UserId, FitzError>{
        return userServise.currentUserPublished().flatMap{ user -> AnyPublisher<UserId, FitzError> in
            if let userId = user?.uid{
                print("userId", userId)
                return Just(userId).setFailureType(to: FitzError.self).eraseToAnyPublisher()
            }else{
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
