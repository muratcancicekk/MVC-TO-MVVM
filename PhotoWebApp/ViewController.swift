//
//  ViewController.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 12.11.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signinClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            // Completion : İşlem bitince ne yapsın?
            // Bu işlem asenkron olmalı ki kullanıcı kaydı sırasında kullanıcıyı arayüzde kilitlemeyelim
            Auth.auth().createUser(withEmail: emailTextField.text!,
                                   password: passwordTextField.text!) { _, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error",
                                      messageInput: error?.localizedDescription ?? "Beklenmedik bir hata oluştu.")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            errorMessage(titleInput: "Hatalı Giriş!", messageInput: "E-mail ya da parolanız boş bırakılamaz..")
        }
    }
    @IBAction func loginClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            // Completion : İşlem bitince ne yapsın?
            // Bu işlem asenkron olmalı ki kullanıcı kaydı sırasında kullanıcıyı arayüzde kilitlemeyelim
            Auth.auth().signIn(withEmail: emailTextField.text!,
                               password: passwordTextField.text!) { _, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error",
                                      messageInput: error?.localizedDescription ?? "Beklenmedik bir hata oluştu.")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            errorMessage(titleInput: "Hatalı Giriş!", messageInput: "E-mail ya da parolanız boş bırakılamaz..")
        }
    }
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput,
                                      message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
