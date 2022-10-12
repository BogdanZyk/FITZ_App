//
//  UserService.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import Combine
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

protocol UserServiceProtocol{
    
    var isPremium: Bool {get}
    
    var currentUser: User? { get }
    
    func currentUserPublished() -> AnyPublisher<User?, Never>
    func signInAnonymously() -> AnyPublisher<User, FitzError>
    func observedAuthChanges() -> AnyPublisher<User?, Never>
    func linkAccount(email: String, pass: String) -> AnyPublisher<Void, FitzError>
    func storeUser(userName: String) -> AnyPublisher<Void, FitzError>
    func getCurrentUser() -> AnyPublisher<FitzUser, FitzError>
    func logout() -> AnyPublisher<Void, FitzError>
    func login(email: String, pass: String) -> AnyPublisher<Void, FitzError>
    
}


final class UserService: UserServiceProtocol{

    
    
    
    @AppStorage("isPremium") var isPremium = false
    
  
    

    private let db = Firestore.firestore()

    
    var currentUser: User? = Auth.auth().currentUser
    
    func currentUserPublished() -> AnyPublisher<User?, Never> {
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
    
    func linkAccount(email: String, pass: String) -> AnyPublisher<Void, FitzError> {
        let emailCredation = EmailAuthProvider.credential(withEmail: email, password: pass)
        return Future<Void, FitzError>{ promise in
            Auth.auth().currentUser?.link(with: emailCredation){result, error in
                if let error = error{
                    return promise(.failure(.default(description: error.localizedDescription)))
                }else{
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, pass: String) -> AnyPublisher<Void, FitzError> {
        return Future<Void, FitzError>{ promise in
            Auth.auth().signIn(withEmail: email, password: pass) { result, error in
                if let error = error{
                    promise(.failure(.default(description: error.localizedDescription)))
                }else{
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, FitzError>{
        return Future<Void, FitzError>{ promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch{
                promise(.failure(.default(description: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    
    func storeUser(userName: String) -> AnyPublisher<Void, FitzError> {
        return Future<Void, FitzError>{ promise in
            
            guard let uid = self.currentUser?.uid else {
              return promise(.failure(.default()))
            }
            let user = FitzUser(uid: uid, userName: userName)
            do {
                try self.db.collection("users")
                    .document(uid)
                    .setData(from: user) { error in
                        if let error = error{
                            promise(.failure(.default(description: error.localizedDescription)))
                        }
                        promise(.success(()))
                    }
            } catch{
                promise(.failure(.default(description: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func getCurrentUser() -> AnyPublisher<FitzUser, FitzError> {
        guard let uid = self.currentUser?.uid else {
            return Fail(error: FitzError.default()).eraseToAnyPublisher()
        }
        let query = db.collection("users").whereField("uid", isEqualTo: uid)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap{ snapshot -> AnyPublisher<FitzUser, FitzError> in
                do{
                    guard let user = try (snapshot.documents.compactMap{
                        try $0.data(as: FitzUser.self)
                    }).first else{
                        return Fail(error: .default(description: "Error set user")).eraseToAnyPublisher()
                    }
                    return Just(user).setFailureType(to: FitzError.self).eraseToAnyPublisher()
                }catch{
                    return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}

struct FitzUser: Codable{
    let uid: String
    var userName: String
}


//func storeUserInformation(email: String, userName: String, completion: @escaping (Result<Bool, Error>) -> Void){
//    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
//    let user = User(uid: uid, email: email, profileImageUrl: "", userName: userName)
//    do {
//        try  FirebaseManager.shared.firestore.collection("users")
//            .document(uid)
//            .setData(from: user, completion: { error in
//                if let error = error{
//                    completion(.failure(error))
//                    return
//                }
//                completion(.success(true))
//            })
//    } catch {
//        completion(.failure(error))
//    }
//}
