//
//  FeedVC.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 12.11.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var postArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fbGetData()
    }
    func fbGetData() {
        let firestoreDB = Firestore.firestore()
            // Altta verdiğimiz collection ismi kesinlikle DB'deki collection ismiyle uyuşmalı yoksa çalışmaz
            // Descending true : En yeni en üstte, false : En eski en üstte
        firestoreDB.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                    // Snapshot optional (Snapshot? : İçinde veri olabilir olmayabilir)
                    // olduğu için bunun kontrolünü yapmamız gerekiyor.
                if snapshot?.isEmpty != true && snapshot != nil {
                    // Eskilerle birlikte kendini tekrarlamasın diye
                    self.postArray.removeAll(keepingCapacity: false)
                        // Documents bize verileri dizi halinde verir.
                    for document in snapshot!.documents {
                        if let image = document.get("imageUrl") as? String {
                            if let comment = document.get("commentText") as? String {
                                if let email = document.get("email") as? String {
                                    let post = Post(email: email, comment: comment, image: image)
                                    self.postArray.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userTextField.text = postArray[indexPath.row].email
        cell.commentTextField.text = postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].image), completed: nil)
        return cell
    }
}
