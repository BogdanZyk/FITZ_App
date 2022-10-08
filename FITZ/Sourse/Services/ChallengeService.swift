//
//  ChallengeService.swift
//  FITZ
//
//  Created by Bogdan Zykov on 15.09.2022.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol{
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitzError>
    func delete(_ challengeId: String) -> AnyPublisher<Void, FitzError>
    func updateChallenge(_ challengeId: String, activities: [Activity]) -> AnyPublisher<Void, FitzError>
    func observedChallenge(userId: UserId) -> AnyPublisher<[Challenge], FitzError>
}


final class ChallengeService: ChallengeServiceProtocol{
   
    
  
    

    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitzError> {
        return Future<Void, FitzError> {promise in
            do{
                _ = try self.db.collection(FBConstants.challenges).addDocument(from: challenge){error in
                    if let error = error{
                        promise(.failure(.default(description: error.localizedDescription)))
                    }else{
                        promise(.success(()))
                    }
                }
            }catch{
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(_ challengeId: String) -> AnyPublisher<Void, FitzError> {
        return Future<Void, FitzError>{ promise in
            self.db.collection(FBConstants.challenges).document(challengeId).delete{ error in
                if let error = error{
                    promise(.failure(.default(description: error.localizedDescription)))
                }else{
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
    func updateChallenge(_ challengeId: String, activities: [Activity]) -> AnyPublisher<Void, FitzError> {
        return Future<Void, FitzError>{ promise in
            self.db.collection(FBConstants.challenges).document(challengeId).updateData(
                ["activities" : activities.map{
                    return ["date": $0.date, "isComplete": $0.isComplete]
                }
                ]){ error in
                    
                if let error = error{
                    promise(.failure(.default(description: error.localizedDescription)))
                }else{
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observedChallenge(userId: UserId) -> AnyPublisher<[Challenge], FitzError> {
        let query = db.collection(FBConstants.challenges)
            .whereField("userId", isEqualTo: userId).order(by: "startDate", descending: true)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap{ snapshot -> AnyPublisher<[Challenge], FitzError> in
                do{
                    let challenges = try snapshot.documents.compactMap{
                        try $0.data(as: Challenge.self)
                    }
                    return Just(challenges).setFailureType(to: FitzError.self).eraseToAnyPublisher()
                }catch{
                    return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}
