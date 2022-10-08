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
    

    
    func send(_ action: Action){
        switch action {
        case .retry:
            observedChallenges()
        case .create:
            showCreateModal.toggle()
        case .timeChange:
            cancellables.removeAll()
            observedChallenges()
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
                withAnimation {
                    self.itemModels = challenges.map{ challenge in
                        .init(challenge,
                         onDelete: {[weak self] id in
                            guard let self = self else {return}
                            self.deleteChallenge(id)
                        }) {[weak self] (id, activites)  in
                            guard let self = self else {return}
                            self.updateChallange(id, activites)
                        }
                    }
                }
                self.showCreateModal = false
                
            }
            .store(in: &cancellables)

    }
    
    private func deleteChallenge(_ challengeId: String){
        challengeService.delete(challengeId).sink { completion in
            switch completion{
                
            case .finished: break
            case .failure(let error):
                self.error = error
            }
        } receiveValue: { _ in
            return
        }
        .store(in: &cancellables)
    }
    
    private func updateChallange(_ id: String, _ activites: [Activity]){
        challengeService.updateChallenge(id, activities: activites)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { _ in
                return
            }
            .store(in: &cancellables)
    }
}


extension ChallengeListViewModel{
    
    enum Action{
        case retry
        case create
        case timeChange
    }
    
}
