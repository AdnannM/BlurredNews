//
//  NewsTableViewCell.swift
//  BlurredNews
//
//  Created by Adnann Muratovic on 03.09.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var authorImageView: UIImageView! {
        didSet {
            authorImageView.layer.masksToBounds = true
            authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        }
    }
    @IBOutlet weak var postAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
//        authorImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
