//
//  MainViewController.swift
//  PagingExam
//
//  Created by KimMinKu on 2018. 8. 11..
//  Copyright © 2018년 KimMinKu. All rights reserved.
//

import UIKit

// MARK: - Overrides
class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var appDatas: [AppData] = Array<AppData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }
}

// MARK: - Actions
extension MainViewController {
    @IBAction func search(_ sender: UIBarButtonItem) {
        // TODO: - 검색기능
    }
}

// MARK: - Fucntions
extension MainViewController {
    func loadData() {
        // TODO: - AppStore Api 호출
    }
}

// MARK: - UITableView Datasource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
    
}


