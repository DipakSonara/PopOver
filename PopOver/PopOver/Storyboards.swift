//
//  Storyboards.swift
//  PopOver
//
//  Created by Dipak Sonara on 15/05/21.
//

import UIKit

struct Storyboard {
    struct Identifier {
        static let homeVC = "ViewControllerID"
        static let tempVC = "TempViewControllerID"
    }
    
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

struct ViewControllerInstance {
    static func fromStoryboard(_ storyboard: UIStoryboard, identifier: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
