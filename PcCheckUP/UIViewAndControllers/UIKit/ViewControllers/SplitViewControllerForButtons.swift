//
//  SplitViewControllerForButtons.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 9/3/22.
//

import Cocoa

//import GBDeviceInfo



class SplitViewControllerForButtons: NSViewController{
    

   
 
    var splitViewForDetail: SplitViewControllerDetail? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    @IBAction func buttonsClicked(_ sender: NSButton) {
   
        switch sender.tag {
        case 0: splitViewForDetail?.buttonInfo = .systemInformation
            
        case 1: splitViewForDetail?.buttonInfo = .hardware
        case 2: splitViewForDetail?.buttonInfo = .os
        case 3: splitViewForDetail?.buttonInfo = .os
        case 4: splitViewForDetail?.buttonInfo = .graphChart
        case 5: splitViewForDetail?.buttonInfo = .battery
        case 6: splitViewForDetail?.buttonInfo = .cpuUsage
        case 7: splitViewForDetail?.buttonInfo = .about
        default:
            break
        }
    
    }
    
    

    
    @IBAction func button1(_ sender: NSButton) {
        
        
    }
    @IBAction func button2(_ sender: NSButton) {
        
        
    }
    
    
}
