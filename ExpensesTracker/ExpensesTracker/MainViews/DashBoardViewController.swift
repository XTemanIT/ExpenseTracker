//
//  ViewController.swift
//  ExpensesTracker
//
//  Created by Artem Sierokurov on 09.11.2021.
//

import UIKit
import RealmSwift

class DashBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTRViewControllerDelegate {
    
    let realm = try! Realm()
    var spendingArray: Results<Spending>!
    
    let cellID = "CellID"
    
    var mainTableView = UITableView()
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true

        createTable()
        createNavButton()
        
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
    
    func createNavButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "add@3x"), landscapeImagePhone: UIImage(imageLiteralResourceName: "add@3x"), style: .plain, target: self, action: #selector(NewAdd))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func NewAdd() {
        let addTransactionVC = AddTRViewController()
        addTransactionVC.delegate = self
        navigationController?.pushViewController(addTransactionVC, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableCell
        let spending = spendingArray[indexPath.row]
        cell.textLabel?.text = spending.category + ": \(spending.amount)"// + "\t \(spending.date)"
        return cell
    }
    //delete row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = spendingArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completionHandler) in
            try! self.realm.write {
                self.realm.delete(editingRow)
            tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    //table header
    func numberOfSections(in tableView: UITableView) -> Int {
        spendingArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let filtredAmount: Int = spendingArray.sum(ofProperty: "amount")
        label.text = "   \(spendingArray[section].account): " + "\(filtredAmount)"
        label.backgroundColor = .lightGray
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }

    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
