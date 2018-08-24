//
//  ResultType.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 21..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import Foundation

// MARK: - Definition
enum ResultType {
    case noResult
    case searchKeywordEmpty
    case connectionFailed
    case ok
}

// MARK: - Value
extension ResultType {
    var description: String {
        switch self {
        case .noResult:             return "No results."
        case .searchKeywordEmpty:   return "Enter search keyword."
        case .connectionFailed:     return "Connection failure."
        case .ok:                   return ""
        }
    }
    
    var isHiddenNoResultLabel: Bool {
        return self == .ok ? true : false
    }
}
