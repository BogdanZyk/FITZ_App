//
//  ChallengeListViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import Combine

final class ChallengeListViewModel: ObservableObject{
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var itemModels = [ChallengeItemModel]()
    
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService())
    {
        self.userService = userService
        self.challengeService = challengeService
        observedChallenges()
    }
    
    private func observedChallenges(){
        userService.currentUser().compactMap {$0?.uid}
            .flatMap { userId -> AnyPublisher<[Challenge], FitzError> in
                return self.challengeService.observedChallenge(userId: userId)
            }.sink { completion in
                switch completion{
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { challenges in
                self.itemModels = challenges.map{.init($0)}
            }
            .store(in: &cancellables)

    }
}
