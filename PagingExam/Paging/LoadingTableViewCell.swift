//
//  LoadingTableViewCell.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 24..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import UIKit

// MARK: - Overrides
class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.indicator.tintColor = UIColor.darkGray
    }
    
    deinit {
        self.indicator.stopAnimating()
    }
}

// MARK: - Functions
extension LoadingTableViewCell {
    func setIndicator() {
        self.indicator.startAnimating()
    }
}
