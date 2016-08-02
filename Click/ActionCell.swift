//
//  ActionCell.swift
//  Click
//
//  Created by Gaby Ecanow on 8/1/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ActionCell: NSObject {
    
    var name = ""
    var full = ""
    
    var myLabel : UILabel!
    var myButton : UIButton!
    
    //=========================================================
    // INIT -- @param FULL, NAME, COLOR, BUTTON-TEXT
    //=========================================================
    convenience init(full: String, name: String, color: UIColor, buttonText: String) {
        self.init()
        
        self.name = name
        self.full = full
        
        myLabel = UILabel(frame: CGRectMake(50, 0, 150, 50))
        myLabel.text = full
        
        myButton = UIButton(frame: CGRectMake(170, 10, 50, 30))
        myButton.backgroundColor = color
        myButton.setTitle(buttonText, forState: .Normal)
        myButton.addTarget(self, action: #selector(cellButtonPressed), forControlEvents: .TouchUpInside)
    }
    
    //=========================================================
    // Handles when a cell button is pressed, and loads
    // a popover view
    //=========================================================
    func cellButtonPressed(sender: UIButton) {
        
        myButton.setTitle(String(Int(myButton.titleLabel!.text!)! + 1), forState: .Normal)
        
        // *** will hold the popover view code
    }
    
}
