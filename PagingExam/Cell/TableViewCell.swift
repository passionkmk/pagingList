//
//  TableViewCell.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 17..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
