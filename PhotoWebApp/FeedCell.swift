//
//  FeedCell.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 16.11.2021.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var userTextField: UILabel!
    @IBOutlet weak var commentTextField: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
