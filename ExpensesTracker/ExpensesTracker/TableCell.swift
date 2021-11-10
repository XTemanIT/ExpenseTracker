//
//  TableCell.swift
//  ExpensesTracker
//
//  Created by Artem Sierokurov on 09.11.2021.
//

import UIKit
//labels in cells
class TableCell: UITableViewCell {
    var labelAmount: UILabel!
    /*override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let label = UILabel()
        label.text = "100"
        if let tmp = label.text {
            if Int(tmp) ?? 0 > 0 {
                label.textColor = .green
            }
            else {
                label.textColor = .red
            }
        }
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 18)
        accessoryView = label
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
}


