//
//  ExpensesViewController.swift
//  ExpensesTracker
//
//  Created by Artem Sierokurov on 09.11.2021.
//

import UIKit
import RealmSwift

class ExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTRViewControllerDelegate {

    let realm = try! Realm()
    var spendingArray: Results<Spending>!
    
    var mainTableView = UITableView()
    let cellID = "CellID"
    var categories: [String] = ["Home","Food","Health","Taxes","Entertainment"]
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addTransactionVC = AddTRViewController()
        addTransactionVC.delegate = self
        
        createTable()
        spendingArray = realm.objects(Spending.self)
        
        super.viewDidLoad()
    }
    
    func createTable() {
        self.mainTableView = UITableView(frame: view.bounds, style: .grouped)
        mainTableView.register(TableCell.self, forCellReuseIdentifier: cellID)
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        mainTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mainTableView)
    }
    
    func twReload() {
        mainTableView.reloadData()
    }
    //Data Source
    //table cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let spending = spendingArray[indexPath.row]
        cell.textLabel?.text = spending.category + "\t\(spending.amount)"
        return cell
    }
    //table header
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let totalAmount: Int = spendingArray.sum(ofProperty: "amount")
        label.text = "   Total: " + "\(totalAmount)"
        label.backgroundColor = .lightGray
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }
    
    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
