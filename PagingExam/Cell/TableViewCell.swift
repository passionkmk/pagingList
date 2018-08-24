//
//  TableViewCell.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 17..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Overrieds
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension TableViewCell {
    func loadCell (_ data: AppData) {
        let imageUrl = URL(string: data.thumbnailUrl)
        self.thumbnailImageView.kf.setImage(with: imageUrl)
        self.titleLabel.text = data.title
        self.subTitleLabel.text = data.subTitle
    }
}
