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
class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    var appDatas: [AppData] = Array<AppData>()
    var resultType: ResultType = .ok
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }
}

// MARK: - Value
extension MainViewController {
    var count: String {
        return "10"
    }
    
    var page: String {
        return "1"
    }
}

// MARK: - Actions
extension MainViewController {
    @IBAction func search(_ sender: UIBarButtonItem) {
        self.reset()
        self.loadData()
    }
}

// MARK: - Fucntions
extension MainViewController {
    func loadData() {
        guard let keyword: String = self.searchTextField.text, keyword.count > 0 else {
            self.resultType = .searchKeywordEmpty
            self.reset()
            self.setStatus()
            return
        }
        let path = "https://itunes.apple.com/search"
        let param: [String: String] = ["term": keyword, "limit": self.count, "country": "KR", "media": "software", "entity": "software", "offset": self.page]
        Alamofire.request(path, method: .get, parameters: param).responseJSON { (r) in
            if let error = r.error {
                self.resultType = .connectionFailed
                self.reset()
                self.setStatus()
                print(error)
                return
            }
            
            guard let object = r.result.value else {
                self.resultType = .connectionFailed
                self.reset()
                self.setStatus()
                return
            }
            
            let data = JSON(object)
            print(data)
            let results = data["results"].arrayValue
            self.appDatas = results.map{ AppData($0) }
            self.tableView.reloadData()
        }
    }
    
    func setStatus() {
        self.noResultLabel.isHidden = self.resultType.isHiddenNoResultLabel
        self.noResultLabel.text = self.resultType.description
    }
    
    func reset() {
        self.appDatas.removeAll()
        self.tableView.reloadData()
    }
}

// MARK: - UITableView Datasource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let data = self.appDatas[indexPath.row]
        cell.loadCell(data)
        return cell
    }
}

// MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.loadData()
        return true
    }
}


