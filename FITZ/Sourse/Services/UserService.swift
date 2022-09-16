//
//  UserService.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import Combine
import FirebaseAuth

protocol UserServiceProtocol{
    func currentUser() -> AnyPublisher<User?, Never>
    func signInAnonymously() -> AnyPublisher<User, FitzError>
    func observedAuthChanges() -> AnyPublisher<User?, Never>
}


final class UserService: UserServiceProtocol{
    
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, FitzError> {
        return Future<User, FitzError> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error{
                    return promise(.failure(.auth(description: error.localizedDescription)))
                }else if let user = result?.user{
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observedAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
}
