//
//  AddTRViewController.swift
//  ExpensesTracker
//
//  Created by Artem Sierokurov on 09.11.2021.
//

import UIKit
import RealmSwift

protocol AddTRViewControllerDelegate {
    func twReload()
}

class AddTRViewController: UIViewController {
    
    let realm = try! Realm()
    
    var delegate: AddTRViewControllerDelegate?
    
    let controls = ["Income", "Expence"]
    let textField1 = UITextField()
    let textField2 = UITextField()
    let textField3 = UITextField()

    override func viewDidLoad() {
        createNav()
        createSegmentedControl()
        createTextFields()
        
        super.viewDidLoad()
    }
    func createNav() {
        navigationItem.title = "Add Transaction"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SaveData))
    }
    
    func createSegmentedControl() {
        let segmentedControls = UISegmentedControl(items: controls)
        segmentedControls.addTarget(self, action: #selector(suitDidChange(_:)), for: .valueChanged)
        segmentedControls.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 2 - 280, width: 200, height: 40)
        view.addSubview(segmentedControls)
    }
    
    func createTextFields() {
        textField1.frame = CGRect(x: 95, y: 240, width: 200, height: 31)
        textField1.placeholder = "Enter Account"
        textField1.borderStyle = .roundedRect
        textField2.frame = CGRect(x: 95, y: 280, width: 200, height: 31)
        textField2.placeholder = "Enter Category"
        textField2.borderStyle = .roundedRect
        textField3.frame = CGRect(x: 95, y: 320, width: 200, height: 31)
        textField3.placeholder = "Enter Sum"
        textField3.borderStyle = .roundedRect
    }
    
    @objc func suitDidChange(_ segmentedControls: UISegmentedControl) {
        switch segmentedControls.selectedSegmentIndex {
        case 0:
            view.addSubview(self.textField1)
            view.addSubview(self.textField2)
            view.addSubview(self.textField3)
        case 1:
            view.addSubview(self.textField1)
            view.addSubview(self.textField2)
            view.addSubview(self.textField3)
        default:
            return
        }
    }
    
    @objc func SaveData() {
        let tmp1 = textField1.text!
        let tmp2 = textField2.text!
        let tmp3 = textField3.text
        let value = Spending(value: ["\(tmp1)", "\(tmp2)", Int(tmp3!)!])
        try! realm.write {
            realm.add(value)
        }
        delegate?.twReload()
    }
}
