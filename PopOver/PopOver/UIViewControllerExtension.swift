//
//  UIViewControllerExtension.swift
//  PopOver
//
//  Created by Dipak Sonara on 02/05/21.
//

import  UIKit

extension UIViewController {
    
    func presentPopover(withDelegate delegate:PopoverViewControllerDelegate,
                        withOptionItems items: [PopoverItem],
                        fromSourceView view: UIView,
                        direction: UIPopoverArrowDirection) {
        let popoverVC = PopoverViewController()
        popoverVC.delegate = delegate
        popoverVC.items = items
        
        switch direction {
        case .left, .right:
            popoverVC.tableHeaderHeight = 1
        case .up:
            popoverVC.tableHeaderHeight = 15
        case .down:
            popoverVC.tableHeaderHeight = 1
        default:
            popoverVC.tableHeaderHeight = 1
        }
        
        guard let popoverPresentationController = popoverVC.popoverPresentationController else { fatalError("Set Modal presentation style") }
        popoverPresentationController.sourceView = view
        popoverPresentationController.delegate = self
        popoverPresentationController.permittedArrowDirections = [ direction ]
        self.present(popoverVC, animated: true, completion: nil)
    }
    
    func presentPopover(withDelegate delegate:PopoverViewControllerDelegate,
                        withOptionItems items: [PopoverItem],
                        fromBarButton barButtonItem: UIBarButtonItem,
                        direction: UIPopoverArrowDirection) {
        let popoverVC = PopoverViewController()
        popoverVC.delegate = delegate
        popoverVC.items = items
        popoverVC.tableHeaderHeight = 15
        
        guard let popoverPresentationController = popoverVC.popoverPresentationController else { fatalError("Set Modal presentation style") }
        popoverPresentationController.barButtonItem = barButtonItem
        popoverPresentationController.delegate = self
        popoverPresentationController.permittedArrowDirections = [ direction ]
        self.present(popoverVC, animated: true, completion: nil)
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
