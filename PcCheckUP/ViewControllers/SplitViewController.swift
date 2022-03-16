//
//  SplitViewController.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 15/3/22.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    @IBOutlet weak var splitViewItemsForButtons: NSSplitViewItem!
    @IBOutlet weak var splitViewItemForDetailedInfo: NSSplitViewItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if let splitViewItemForButtonVC = splitViewItemsForButtons.viewController as? SplitViewControllerForButtons {
            if let detailVC = splitViewItemForDetailedInfo.viewController as? SplitViewControllerDetail {
                splitViewItemForButtonVC.splitViewForDetail = detailVC
            }
        }
    }
    
}
