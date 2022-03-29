//
//  SplitViewControllerDetail.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 15/3/22.
//

import Cocoa

import GBDeviceInfo

class SplitViewControllerDetail: NSViewController {
    @IBOutlet var textView: NSTextView!
    
    
    let info  = GBDeviceInfo()
    var sys = System()
    let memoryUsage = System.memoryUsage()
    var buttonInfo: InfoButton!{
        didSet {
            let stringForPrint =  printWhenLoaded(infoName: buttonInfo)
           // print(stringForPrint!)
            textView.string = stringForPrint!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    
}

