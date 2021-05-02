//
//  PopoverItem.swift
//  PopOver
//
//  Created by Dipak Sonara on 02/05/21.
//

import Foundation
import UIKit

protocol PopoverItem {
    var text: String { get }
    var value: Double { get }
    var isSelected: Bool { get set }
    var font: UIFont { get set }
}

extension PopoverItem {
    func sizeForDisplayText() -> CGSize {
        return text.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
