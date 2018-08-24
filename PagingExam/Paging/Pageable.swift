//
//  Pageable.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 24..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import UIKit

// MARK: - Definition
protocol Pageable: class {
    var currentPage: Int { get set }
    var pagePerCount: Int { get }
    var currentCount: Int { get }
    var isShouldShowLoadingCell: Bool { get set }
    func fetchNextPage()
    func reset()
}

extension Pageable {
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard self.isShouldShowLoadingCell else { return false }
        return indexPath.row == self.currentCount
    }
    
    func initLoadingTableCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingTableViewCell")
    }
    
    func getLodingTableCell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell") as! LoadingTableViewCell
        cell.setIndicator()
        return cell
    }
}
