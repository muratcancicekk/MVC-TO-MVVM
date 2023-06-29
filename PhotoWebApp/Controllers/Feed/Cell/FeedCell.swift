//
//  FeedCell.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 16.11.2021.
//

import UIKit
import SDWebImage


class FeedCell: UITableViewCell {
    @IBOutlet weak var userTextField: UILabel!
    @IBOutlet weak var commentTextField: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(data: Post?) {
        guard let data = data else { return }
        userTextField.text = data.email
        commentTextField.text = data.comment
        postImageView.sd_setImage(with: URL(string: data.image ), completed: nil)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
