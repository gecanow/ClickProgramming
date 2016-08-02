//
//  ActionCell.swift
//  Click
//
//  Created by Gaby Ecanow on 8/1/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ActionCell: NSObject {
    
    var type : ActionType!
    var name = ""
    
    var myLabel : UILabel!
    var myButton : UIButton!
    
    var isMutable = true
    
    //=========================================================
    // INIT -- @param NAME, TYPE, COLOR, BUTTON-TEXT
    //=========================================================
    convenience init(name: String, type: ActionType, color: UIColor, buttonText: String) {
        self.init()
        
        self.name = name
        self.type = type
        
        myLabel = UILabel(frame: CGRectMake(50, 0, 150, 50))
        myLabel.text = name
        
        myButton = UIButton(frame: CGRectMake(170, 10, 50, 30))
        myButton.backgroundColor = color
        myButton.setTitle(buttonText, forState: .Normal)
        myButton.addTarget(self, action: #selector(cellButtonPressed), forControlEvents: .TouchUpInside)
    }
    
    //=========================================================
    // INIT -- @param NAME, COLOR
    //=========================================================
    convenience init(name: String, color: UIColor) {
        self.init()
        
        self.name = name
        myLabel = UILabel(frame: CGRectMake(50, 0, 300, 50))
        
        isMutable = false
    }
    
    //=========================================================
    // Handles when a cell button is pressed, and loads
    // a popover view
    //=========================================================
    func cellButtonPressed(sender: UIButton) {
        
        if type == ActionType.Move {
            
            myButton.setTitle(String(Int(myButton.titleLabel!.text!)! + 1), forState: .Normal)
            
        } else if type == ActionType.Turn {
            
            let options = ["North", "East", "South", "West"]
            var index = Int(options.indexOf((myButton.titleLabel?.text)!)!) + 1
            
            if index == options.count { index = 0 }
            
            myButton.setTitle(options[index], forState: .Normal)
        } else {}
        
        // *** will hold the popover view code
    }
    
}
