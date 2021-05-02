//
//  TempViewController.swift
//  PopOver
//
//  Created by Dipak Sonara on 01/05/21.
//

import UIKit

class TempViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var popoverType: PopOverType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        switch popoverType {
        case .button:
            textField.isHidden = true
        case .textfield:
            button.isHidden = true
        default: break
            
        }
    }
    
    @IBAction func btnTapped() {
        let item1 = PopoverModel(text: "10", value: 10, font: UIFont.systemFont(ofSize: 13), isSelected: false)
        let item2 = PopoverModel(text: "20", value: 20, font: UIFont.systemFont(ofSize: 13), isSelected: true )
        self.presentPopover(withDelegate: self,
                            withOptionItems: [item1, item2],
                            fromSourceView: self.button,
                            direction: .left)
    }
}

extension TempViewController: PopoverViewControllerDelegate {
    func popOverViewControler(_ controller: PopoverViewController, didSelectOptionItem item: PopoverItem) {
        debugPrint(item)
    }
}

extension TempViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let item1 = PopoverModel(text: "Option 1", value: 1, font: UIFont.systemFont(ofSize: 13), isSelected: false)
        let item2 = PopoverModel(text: "Option 2", value: 2, font: UIFont.systemFont(ofSize: 13), isSelected: true )
        self.presentPopover(withDelegate: self,
                            withOptionItems: [item1, item2],
                            fromSourceView: self.textField,
                            direction: .down)
        return false
    }
}
