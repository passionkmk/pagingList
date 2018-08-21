//
//  DataModel.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 17..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AppData {
    let thumbnailUrl: String
    let title: String
    let subTitle: String
    
    init(_ data: JSON) {
        self.thumbnailUrl = data["artworkUrl100"].stringValue
        self.title = data["trackName"].stringValue
        self.subTitle = data["description"].stringValue
    }
}
