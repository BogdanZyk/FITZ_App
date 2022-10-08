//
//  LoginSignupViewModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import Foundation
import Combine


final class LoginSignupViewModel: ObservableObject{
    
    private var mode: Mode
    
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = false
    @Published var isPushed: Bool = true
    @Published var showAlert: Bool = false
    @Published var error: FitzError?
    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    
    init(mode: Mode,
         userService: UserServiceProtocol = UserService()
    ){
        self.mode = mode
        self.userService = userService
        
        Publishers.CombineLatest3($email, $password, $userName)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map{ [weak self] (email, pass, name) in
                guard let self = self else {return false}
                return self.isValidEmail(email) && self.isValidPass(pass) && self.isValidName(name)
            }.assign(to: &$isValid)
    }
    
    var isSignUpMode: Bool{
        mode == .signup
    }
    
    var title: String{
        switch mode {
            
        case .login:
            return "Welcome back!"
        case .signup:
            return "Create an account"
        }
    }
    
    var subtitle: String{
        switch mode{
            
        case .login:
            return "Log in with your email"
        case .signup:
            return "Sing up via email"
        }
    }
    
    var buttonTitle: String{
        switch mode{
            
        case .login:
            return "Log in"
        case .signup:
            return "Sing up"
        }
    }
    
    func tappedActionButton(){
        switch mode{
            
        case .login:
            userService.login(email: email, pass: password)
                .sink {[weak self] completion in
                    guard let self = self else {return}
                    switch completion{
                    case .finished: break
                    case .failure(let error):
                        self.showAlert = true
                        self.error = error
                    }
                } receiveValue: { _ in}
                .store(in: &cancellables)

        case .signup:
            userService.linkAccount(email: email, pass: password)
                .sink { [weak self] completion in
                    guard let self = self else {return}
                    switch completion{
                    case .finished:
                        self.storeUser()
                    case .failure(let error):
                        self.showAlert = true
                        self.error = error
                    }
                } receiveValue: { _ in}
                .store(in: &cancellables)
        }
    }
    
    func storeUser(){
        userService.storeUser(userName: userName)
            .sink { completion in
                switch completion{
                case .finished:
                    self.isPushed = false
                case .failure(let error):
                    self.showAlert = true
                    self.error = error
                }
            } receiveValue: { _ in}
            .store(in: &cancellables)
    }
}

extension LoginSignupViewModel{
    enum Mode{
        case login
        case signup
    }
}



extension LoginSignupViewModel{
    
    private func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) && email.count > 5
    }
    
    private func isValidPass(_ pass: String) -> Bool{
        return pass.count >= 6
    }
    
    private func isValidName(_ name: String) -> Bool{
        !name.isEmpty
    }
}
