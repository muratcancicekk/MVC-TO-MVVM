//
//  Post.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 17.11.2021.
//

import Foundation

class Post {
    var email: String
    var comment: String
    var image: String
    init (email: String, comment: String, image: String) {
        self.email = email
        self.comment = comment
        self.image = image
    }
}
