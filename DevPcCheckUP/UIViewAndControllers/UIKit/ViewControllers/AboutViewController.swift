//
//  AboutViewController.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 15/3/22.
//

import Cocoa

class AboutViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }
    @IBAction func exitButtonPressed(_ sender: NSButton) {
        self.view.window?.windowController?.close()
    }
    
}
