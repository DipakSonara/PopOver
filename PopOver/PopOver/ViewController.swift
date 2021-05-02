//
//  ViewController.swift
//  PopOver
//
//  Created by Dipak Sonara on 01/05/21.
//

import UIKit


enum PopOverType: String {
    case button = "From UIButton"
    case textfield = "From UITextField"
    case cell = "From UITableViewCell"
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            tableView.tableFooterView = UIView()
        }
    }
    
    var items = [PopOverType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        self.title = "PopOvers"
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped))
        self.navigationItem.rightBarButtonItem = rightBarItem
        items = [.button, .textfield, .cell]
    }
    
    @objc func btnAddTapped(_ sender: UIBarButtonItem) {
        let item1 = PopoverModel(text: "Option 1", value: 1, font: UIFont.systemFont(ofSize: 13), isSelected: false)
        let item2 = PopoverModel(text: "Option 2", value: 2, font: UIFont.systemFont(ofSize: 13), isSelected: true )
        self.presentPopover(withDelegate: self,
                            withOptionItems: [item1, item2],
                            fromBarButton: sender,
                            direction: .any)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TempViewController {
            vc.popoverType = .button
        }
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = items[indexPath.row].rawValue
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TempViewControllerID") as! TempViewController
        
        switch indexPath.row {
        case 0:
            vc.popoverType = .button
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            vc.popoverType = .textfield
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            let item1 = PopoverModel(text: "Option 1", value: 1, font: UIFont.systemFont(ofSize: 13), isSelected: false)
            let item2 = PopoverModel(text: "Option 2", value: 2, font: UIFont.systemFont(ofSize: 13), isSelected: true )
            self.presentPopover(withDelegate: self,
                                withOptionItems: [item1, item2],
                                fromSourceView: cell,
                                direction: .up)
        default:
            break
        }
        
    }
}


extension ViewController: PopoverViewControllerDelegate {
    func popOverViewControler(_ controller: PopoverViewController, didSelectOptionItem item: PopoverItem) {
        debugPrint(item)
    }
}
