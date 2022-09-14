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
}


final class ChallengeService: ChallengeServiceProtocol{
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitzError> {
        return Future<Void, FitzError> {promise in
            do{
                _ = try self.db.collection("challenges").addDocument(from: challenge){error in
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
    
    
}
