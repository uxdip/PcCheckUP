//
//  SplitViewControllerForButtons.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 9/3/22.
//

import Cocoa
import SystemKit
import GBDeviceInfo



class SplitViewControllerForButtons: NSViewController{
    

   
 
    var splitViewForDetail: SplitViewControllerDetail? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    @IBAction func buttonsClicked(_ sender: NSButton) {
   
        switch sender.tag {
        case 0: splitViewForDetail?.buttonInfo = .systemInformation
            
        case 1: splitViewForDetail?.buttonInfo = .systemInformation
        case 2: splitViewForDetail?.buttonInfo = .systemInformation
        case 3: splitViewForDetail?.buttonInfo = .systemInformation
        case 4: splitViewForDetail?.buttonInfo = .systemInformation
        case 5: splitViewForDetail?.buttonInfo = .systemInformation
        case 6: splitViewForDetail?.buttonInfo = .systemInformation
        case 7: splitViewForDetail?.buttonInfo = .systemInformation
        default:
            break
        }
    
    }
    
    

    
    @IBAction func button1(_ sender: NSButton) {
        
        
    }
    @IBAction func button2(_ sender: NSButton) {
        
        
    }
    
    
}
