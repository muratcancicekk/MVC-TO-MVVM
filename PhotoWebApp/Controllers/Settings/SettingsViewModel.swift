//
//  SettingsViewModel.swift
//  PhotoWebApp
//
//  Created by Murat Çiçek on 28.06.2023.
//

import Foundation
import Firebase

protocol SettingsViewModelInterface: AnyObject {
    var view: SettingsViewInterface? { get set }
    func signoutClicked()
}

final class SettingsViewModel {
    weak var view: SettingsViewInterface?
}

extension SettingsViewModel: SettingsViewModelInterface {
    func signoutClicked() {
        do {
            try Auth.auth().signOut()
            view?.performSegue(identifier: "toVC")
        } catch {
            Helpers.shared.errorMessage(title: "ERROR", message: error.localizedDescription)
        }
    }
}
