//
//  UITableViewCellExtension.swift
//  PopOver
//
//  Created by Dipak Sonara on 02/05/21.
//

import UIKit

extension UITableViewCell {
    func configure(with optionItem: PopoverItem) {
        textLabel?.text = optionItem.text
        textLabel?.font = optionItem.font
        accessoryType = optionItem.isSelected ? .checkmark : .none
    }
}
