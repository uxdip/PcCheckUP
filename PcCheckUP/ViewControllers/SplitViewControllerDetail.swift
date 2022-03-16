//
//  SplitViewControllerDetail.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 15/3/22.
//

import Cocoa
import SystemKit
import GBDeviceInfo

class SplitViewControllerDetail: NSViewController {

    var sys = System()
    let memoryUsage = System.memoryUsage()
    var buttonInfo: InfoButton!{
        didSet {
            let stringForPrint =  printWhenLoaded(infoName: buttonInfo)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    
}

