//
//  SettingsVC.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 12.11.2021.
//

import UIKit

protocol SettingsViewInterface: AnyObject, SeguePerformable {
}

final class SettingsVC: UIViewController {
    private lazy var viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
    }
    @IBAction func signoutClicked(_ sender: Any) {
        viewModel.signoutClicked()
    }
}
extension SettingsVC: SettingsViewInterface {}
