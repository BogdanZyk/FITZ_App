//
//  ChallengeListViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//
import SwiftUI
import Combine

final class ChallengeListViewModel: ObservableObject{
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var itemModels = [ChallengeItemModel]()
    @Published private(set) var error: FitzError?
    @Published private(set) var isLoading: Bool = false
    @Published var showCreateModal: Bool = false
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService())
    {
        self.userService = userService
        self.challengeService = challengeService
        observedChallenges()
    }
    
    enum Action{
        case retry
        case create
    }
    
    func send(_ action: Action){
        switch action {
        case .retry:
            observedChallenges()
        case .create:
            showCreateModal.toggle()
        }
    }
    
    private func observedChallenges(){
        isLoading = true
        userService.currentUserPublished().compactMap {$0?.uid}
            .flatMap { [weak self] userId -> AnyPublisher<[Challenge], FitzError> in
                guard let self = self else {return Fail(error: .default()).eraseToAnyPublisher()}
                return self.challengeService.observedChallenge(userId: userId)
            }.sink {[weak self] completion in
                guard let self = self else {return}
                self.isLoading = false
                switch completion{
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else {return}
                self.isLoading = false
                self.error = nil
                self.itemModels = challenges.map{.init($0)}
                self.showCreateModal = false
                
            }
            .store(in: &cancellables)

    }
}
