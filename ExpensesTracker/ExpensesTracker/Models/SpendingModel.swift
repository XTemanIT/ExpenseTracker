//
//  SpendingModel.swift
//  ExpensesTracker
//
//  Created by Artem Sierokurov on 10.11.2021.
//

import RealmSwift

class Spending: Object {
    @objc dynamic var account = ""
    @objc dynamic var category = ""
    @objc dynamic var amount = 1
    @objc dynamic var date = NSDate()
}
