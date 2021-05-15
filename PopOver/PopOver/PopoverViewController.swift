//
//  PopoverViewController.swift
//  PopOver
//
//  Created by Dipak Sonara on 02/05/21.
//

import UIKit

struct Constants {
    static let tableRowHeight: CGFloat = 40.0
}

protocol PopoverViewControllerDelegate: class {
    func popOverViewControler(_ controller: PopoverViewController, didSelectOptionItem item: PopoverItem)
}

class PopoverViewController: UIViewController {

    var items = [PopoverItem]() {
        didSet {
            calculateAndSetPreferredContentSize()
        }
    }
    
    var tableHeaderHeight: CGFloat = 15.0
    
    private(set) weak var tableView: UITableView?
    weak var delegate: PopoverViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .popover
    }
       
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UITableView(frame: .zero, style: .plain)
        tableView = view as? UITableView
        tableView?.isScrollEnabled = false
        tableView?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView?.accessibilityIdentifier = "PopOverTableViewIdentifier"
    }
    
    func calculateAndSetPreferredContentSize() {
        let approxAccessoryViewWidth: CGFloat = 56
        let maxWidth = items.compactMap{ $0 }.reduce(0) { $1.sizeForDisplayText().width + approxAccessoryViewWidth > $0 ? $1.sizeForDisplayText().width + 66 : $0 }
        let totalItems = CGFloat(items.compactMap{ $0 }.count)
        let totalHeight = totalItems * Constants.tableRowHeight +  tableHeaderHeight
        preferredContentSize = CGSize(width: maxWidth, height: totalHeight)
    }
}

extension PopoverViewController:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: tableHeaderHeight))
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = items[indexPath.row]
        cell.configure(with:item)
        cell.accessibilityIdentifier = "PopOverTableViewCell"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = items.firstIndex(where: {$0.isSelected == true}) {
            var item = items[row]
            item.isSelected = false
            items[row] = item
        }
        
        var item = items[indexPath.row]
        item.isSelected = true
        
        if let row = items.firstIndex(where: {$0.value == item.value}) {
            items[row] = item
        }
        self.tableView?.reloadData()
        self.dismiss(animated: true) {
            let item = self.items[indexPath.row]
            self.delegate?.popOverViewControler(self, didSelectOptionItem: item)
        }
    }
}
