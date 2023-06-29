//
//  ViewController.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 12.11.2021.
//

import UIKit
import Firebase

protocol SignInInterface: AnyObject, SeguePerformable {
    
}

final class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private lazy var viewmodel = SignInViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewmodel.view = self
    }
    @IBAction func signinClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            viewmodel.signinClicked(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        } else {
            Helpers.shared.errorMessage(title: "Hatalı Giriş!", message: "E-mail ya da parolanız boş bırakılamaz..")
        }
    }
    @IBAction func loginClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            viewmodel.loginClicked(email: emailTextField.text ?? "" , password: passwordTextField.text ?? "")
        } else {
            Helpers.shared.errorMessage(title: "Hatalı Giriş!", message: "E-mail ya da parolanız boş bırakılamaz..")        }
    }
}
extension SignInViewController: SignInInterface {}
