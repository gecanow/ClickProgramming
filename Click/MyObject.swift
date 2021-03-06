//
//  MyObject.swift
//  Click
//
//  Created by Gaby Ecanow on 8/1/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class MyObject: UILabel {

    var radians = 0.0
    var direction = "East"
    
    var distance = 0.0
    
    var startCenter : CGPoint!
    var destinationBoardSquare : BoardSquare?
    
    //=========================================================
    // INIT: @param CENTER, WIDTH
    //=========================================================
    convenience init(center: CGPoint, width: CGFloat) {
        self.init()
        startCenter = center
        
        let w = width * 1.5
        
        self.frame = CGRectMake(0, 0, w, w)
        self.center = center
        
        let imageView = UIImageView(frame: self.frame)
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "turtle")
        self.addSubview(imageView)
    }
    
    //=========================================================
    // Handles resetting the player to be in
    // the top left corner and facing east
    //=========================================================
    func reset() {
        self.center = startCenter
        self.transform = CGAffineTransformMakeRotation(0)
        
        radians = 0
    }
    
    //------------------//
    // ACTION FUNCTIONS //
    //------------------//
    
    //=========================================================
    // Handles moving forward a certain distance
    //=========================================================
    func moveForward() {
        UIView.animateWithDuration(2.0) {
            self.center.x += CGFloat(cos(self.radians) * self.distance)
            self.center.y += CGFloat(sin(self.radians) * self.distance)
        }
    }
    
    //=========================================================
    // Handles turning a certain radians
    //=========================================================
    func turn() {
        switch (direction) {
            case "East"  : radians = 0.0
            case "South" : radians = M_PI / 2
            case "West"  : radians = M_PI
            case "North" : radians = 3 * M_PI / 2
            default      : radians = 0.0
        }
        
        self.transform = CGAffineTransformMakeRotation(CGFloat(radians))
    }
    
    /* To call the functions moveforward and turn:
        
        LOOP THROUGH:
        for _ in 0...3 {
     
            MUST SET object.distance TO THE DISTANCE BECAUSE NSTimer DOESN'T ALLOW PARAMETERS
            testObject.distance = 200.0
            NSTimer.scheduledTimerWithTimeInterval(count, target: testObject, selector: #selector(testObject.moveForward), userInfo: nil, repeats: false)
 
            INCREMENT THE COUNTER ONLY AFTER A MOVE FORWARD
            count += countI
 
            MUST SET object.turnDegrees TO THE DEGREES BECAUSE NSTimer DOESN'T ALLOW PARAMETERS
            testObject.turnDegrees = 90.0
            NSTimer.scheduledTimerWithTimeInterval(count, target: testObject, selector: #selector(testObject.turn), userInfo: nil, repeats: false)
        }
     */

}
