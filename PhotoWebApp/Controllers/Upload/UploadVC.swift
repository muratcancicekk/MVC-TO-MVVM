//
//  UploadVC.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 12.11.2021.
//

import UIKit

protocol UploadInterface: AnyObject {
    func configure()
    func imageViewConfigure()
    func reloadView()
    func textFieldEndEditing()
    func pickerConfigure()
}

final class UploadVC: UIViewController{
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    private lazy var viewModel = UploadViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidload()
    }
    
    @IBAction func uploadButtonclicked(_ sender: Any) {
        guard let uploadImageView = uploadImageView.image else { return }
        guard let comment = commentTextField.text else { return }

        viewModel.uploadButtonclicked(uploadImage: uploadImageView, comment: comment)
    }
    @objc func closeKeyboard() {
        viewModel.closeKeyboard()
    }
    @objc func chooseImage() {
        viewModel.chooseImage()
    }
}
extension UploadVC: UploadInterface {
    func pickerConfigure() {
        let  picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        present(picker, animated: true, completion: nil)
    }
    
    func textFieldEndEditing() {
        view.endEditing(true)
    }
    
    func reloadView() {
        uploadImageView.image = UIImage(named: "upload")
        commentTextField.text = ""
        tabBarController?.selectedIndex = 0
    }
    
    func configure() {
        imageViewConfigure()
    }
    
    func imageViewConfigure() {
        uploadImageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImageView.addGestureRecognizer(imageGestureRecognizer)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
}
extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
