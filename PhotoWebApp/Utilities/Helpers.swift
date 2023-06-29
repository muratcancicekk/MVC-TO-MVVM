//
//  Helpers.swift
//  PhotoWebApp
//
//  Created by Murat Çiçek on 28.06.2023.
//

import Foundation
import UIKit

final class Helpers {
    static let shared = Helpers()
    
    func errorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
    }
}
