//
//  BoardSquare.swift
//  Maze
//
//  Created by Diva Harsoor on 7/31/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class BoardSquare: NSObject {
    
    let imageNames = ["square", "obstacle", "goal"]
    //let imageNames = ["rock", "water", "house"]
    
    var position : Int = 0
    var isObstacle : Bool = false
    var isGoal : Bool = false
    var image : UIImageView = UIImageView(image: UIImage(named: "square"))
    var center : (xPos: CGFloat, yPos: CGFloat)?
    
    //=========================================================
    // INIT -- @param POSITION
    //=========================================================
    convenience init(position: Int) {
        self.init()
        self.position = position
        self.isObstacle = false
        self.isGoal = false
        self.image = UIImageView(image: UIImage(named: imageNames[0]))
    }
    
    //=========================================================
    // INIT -- @param POSITION, IsOBSTACLE, IsGoal
    //=========================================================
    convenience init(position: Int, isObstacle : Bool, isGoal : Bool) {
        self.init()
        self.position = position
        self.isObstacle = isObstacle
        self.isGoal = isGoal
        if isObstacle {
            image = UIImageView(image: UIImage(named: imageNames[1]))
        }
        else if isGoal {
            image = UIImageView(image: UIImage(named: imageNames[2]))
        }
        else {
            image = UIImageView(image: UIImage(named: imageNames[0]))
        }
    }
    
    //=========================================================
    // Enumerated designation variable
    //=========================================================
    enum Designation {
        case Square
        case Obstacle
        case Goal
    }
    
    //=========================================================
    // Changes the destination of this board square
    //=========================================================
    func changeDesignation(newDesignation nd : Designation) {
        switch (nd) {
        case .Square:
            isObstacle = false
            isGoal = false
            image = UIImageView(image: UIImage(named: imageNames[0]))
        case .Obstacle:
            isObstacle = true
            isGoal = false
            image = UIImageView(image: UIImage(named: imageNames[1]))
        case .Goal:
            isObstacle = false
            isGoal = true
            image = UIImageView(image: UIImage(named: imageNames[2]))
        }
        
    }
}
