//
//  Service.swift
//  PhotoWebApp
//
//  Created by Murat Çiçek on 28.06.2023.
//

import Foundation
import UIKit
import Firebase

final class Service {
    static let shared = Service()
    
    func uploadData(uploadImage: UIImage, comment: String, success: @escaping (() -> Void?), failure: @escaping ((String) -> Void?)) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("images")
        
        if let data = uploadImage.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data, metadata: nil) { [weak self] (_, error ) in
                if error != nil {
                    failure(error?.localizedDescription ?? "")
                } else {
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                                let firestoreDB = Firestore.firestore()
                                
                                let firestorePost = ["imageUrl": imageUrl,
                                                     "commentText": comment,
                                                     "email": Auth.auth().currentUser!.email!,
                                                     "date": FieldValue.serverTimestamp()] as [String: Any]
                                
                                firestoreDB.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error != nil {
                                        failure(error?.localizedDescription ?? "")
                                    } else {
                                        success()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func firebaseGetDatas(completion: @escaping (Result<[Post], Error>) -> Void) {
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let snapshot = snapshot {
                    var posts: [Post] = []
                    for document in snapshot.documents {
                        if let image = document.get("imageUrl") as? String,
                           let comment = document.get("commentText") as? String,
                           let email = document.get("email") as? String {
                            let post = Post(email: email, comment: comment, image: image)
                            posts.append(post)
                        }
                    }
                    completion(.success(posts))
                }
            }
        }
    }
}
