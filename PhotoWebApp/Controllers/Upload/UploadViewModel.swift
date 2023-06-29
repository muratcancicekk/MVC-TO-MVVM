//
//  UploadViewModel.swift
//  PhotoWebApp
//
//  Created by Murat Çiçek on 28.06.2023.
//

import Foundation
import Firebase

protocol UploadViewModelInteface {
    var view: UploadInterface? { get set }
    func viewDidload()
    func uploadButtonclicked(uploadImage: UIImage, comment: String)
    func closeKeyboard()
    func chooseImage()
}
final class UploadViewModel {
    weak var view: UploadInterface?
}
extension UploadViewModel: UploadViewModelInteface {
    func chooseImage() {
        view?.pickerConfigure()
    }
    
    func closeKeyboard() {
        view?.textFieldEndEditing()
    }
    
    func uploadButtonclicked(uploadImage: UIImage, comment: String) {
        Service.shared.uploadData(uploadImage: uploadImage, comment: comment, success: { [weak self] in
            self?.view?.reloadView()
        }, failure: { error in
            Helpers.shared.errorMessage(title: "ERROR", message: error)
        })
    }
    
    func viewDidload() {
        view?.configure()
    }
}
