//
//  FeedViewModel.swift
//  PhotoWebApp
//
//  Created by Murat Çiçek on 28.06.2023.
//

import Foundation
import Firebase


protocol FeedViewModelInterface: AnyObject {
    var view: FeedViewInterface? {get set}
    var postArray: [Post]? { get }
    
    func viewDidLoad()
    func firebaseGetDatas()
}

final class FeedViewModel {
    weak var view: FeedViewInterface?
    var postArray: [Post]?
    
}

extension FeedViewModel: FeedViewModelInterface {
    
    func firebaseGetDatas() {
        Service.shared.firebaseGetDatas(completion: { result in
            switch result {
            case .success(let posts):
                self.postArray = posts
                self.view?.tableViewReload()
            case .failure(let failure):
                Helpers().errorMessage(title: "ERROR", message: failure.localizedDescription)
            }
        })
    }
    
    func viewDidLoad() {
        view?.tableViewConfigure()
        firebaseGetDatas()
    }
}
