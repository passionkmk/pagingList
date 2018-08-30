//
//  MainViewController.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 11..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// MARK: - Overrides
class MainViewController: UIViewController, Pageable {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    var appDatas: [AppData] = Array<AppData>()
    var resultType: ResultType = .ok
    
    // Pageable Value
    var currentPage: Int = 0
    var pagePerCount: Int { return 10 }
    var currentCount: Int { return self.appDatas.count }
    var isShouldShowLoadingCell: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLoadingTableCell(tableView: self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }
}

// MARK: - Paging Function
extension MainViewController {
    func fetchNextPage() {
        self.currentPage += 1
        self.loadData()
    }
    
    func reset() {
        self.currentPage = 0
        self.appDatas.removeAll()
        self.loadData()
    }
}

// MARK: - Actions
extension MainViewController {
    @IBAction func search(_ sender: UIBarButtonItem) {
        self.reset()
    }
}

// MARK: - Fucntions
extension MainViewController {
    func loadData() {
        guard let keyword: String = self.searchTextField.text, keyword.count > 0 else {
            self.setResultUI(type: .searchKeywordEmpty)
            return
        }
        let path = "https://itunes.apple.com/search"
        // TODO: - Offset keyword maybe wrong.
        let param: [String: String] = ["term": keyword, "limit": String(self.pagePerCount), "country": "KR", "media": "software", "entity": "software", "offset": String(self.currentPage)]
        Alamofire.request(path, method: .get, parameters: param).responseJSON { (r) in
            if let error = r.error {
                self.setResultUI(type: .connectionFailed)
                print(error)
                return
            }
            
            guard let object = r.result.value else {
                self.setResultUI(type: .connectionFailed)
                return
            }
            
            let data = JSON(object)
            print(param)
            let results = data["results"].arrayValue
            if results.count == 0 && self.appDatas.count == 0 {
                self.setResultUI(type: .noResult)
                return
            }
            self.isShouldShowLoadingCell = results.count == self.pagePerCount
            self.appDatas += results.map{ AppData($0) }
            self.tableView.reloadData()
        }
    }
    
    func setResultUI(type: ResultType) {
        self.resultType = type
        self.clear()
        self.setStatus()
    }
    
    func clear() {
        self.currentPage = 0
        self.appDatas.removeAll()
        self.tableView.reloadData()
    }
    
    func setStatus() {
        self.noResultLabel.isHidden = self.resultType.isHiddenNoResultLabel
        self.noResultLabel.text = self.resultType.description
    }
}

// MARK: - UITableView Datasource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isShouldShowLoadingCell ? self.appDatas.count + 1 : self.appDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.appDatas.count {
            return self.isShouldShowLoadingCell ? self.getLodingTableCell(tableView: tableView) : UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let data = self.appDatas[indexPath.row]
        cell.loadCell(data)
        return cell
    }
}

// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.isLoadingIndexPath(indexPath) else {
            return
        }
        self.fetchNextPage()
    }
}

// MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.reset()
        return true
    }
}


