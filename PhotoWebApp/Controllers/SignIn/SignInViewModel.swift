//
//  SignInViewModel.swift
//  PhotoWebApp
//
//  Created by Murat Çiçek on 29.06.2023.
//

import Foundation
import Firebase

protocol SignInViewModelInterface: AnyObject {
    var view: SignInInterface? { get set }
    func signinClicked(email: String, password: String)
    func loginClicked(email: String, password: String)
}

final class SignInViewModel {
    weak var view: SignInInterface?
}

extension SignInViewModel: SignInViewModelInterface {
    func loginClicked(email: String, password: String) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { [weak self] _, error in
            if error != nil {
                Helpers.shared.errorMessage(title: "ERROR", message: error?.localizedDescription ?? "Error")
            } else {
                self?.view?.performSegue(identifier: "toFeedVC")
            }
        }
    }
    
    func signinClicked(email: String, password: String) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { [weak self] _, error in
            if error != nil {
                Helpers.shared.errorMessage(title: "ERROR", message: error?.localizedDescription ?? "Error")
            } else {
                self?.view?.performSegue(identifier: "toFeedVC")
            }
        }
    }
}
