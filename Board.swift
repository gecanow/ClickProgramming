//
//  Board.swift
//  Maze
//
//  Created by Diva Harsoor on 7/31/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class Board: NSObject {
    
    // board-square related fields
    var board : [[BoardSquare]] = []
    var width : Int = 0
    var length : Int = 0
    var launch : Int = 0
    var goal : Int = 0
    var obstacles : [Int] = []
    
    // player-related fields
    var player : MyObject!
    var playerCell : BoardSquare!
    
    //=========================================================
    // INIT -- @param WIDTH, LENGTH, LAUNCH, GOAL, OBSTACLES
    //=========================================================
    convenience init(width: Int, length: Int, launch: Int, goal: Int, obstacles: [Int]) {
        self.init()
        self.width = width < length ? length : width
        self.length = width < length ? width : length
        self.launch = launch
        self.goal = goal
        self.obstacles = obstacles
    }
    
    //=========================================================
    // INIT -- @param WIDTH, LENGTH
    //=========================================================
    convenience init(width: Int, length: Int) {
        self.init()
        self.width = width < length ? length : width
        self.length = width < length ? width : length
        self.launch = 0
        self.goal = width * length - 1
        let n = width < length ? width : length
        for _ in 0..<n {
            self.obstacles.append(Int(arc4random_uniform(UInt32((width - 1)*(length - 1))) + 1))
        }
    }
    
    //=========================================================
    // Handles loading the board:
    //    1. Gives each board square an image
    //    2. Decides whether a board square has certain
    //              properties
    //    3. Fills up the board[][] array with boardSquares
    //    4. Instantiates the player in the upper left
    //              corner
    //=========================================================
    func loadBoard(view: UIView) {
        var count = 0
        let w = view.frame.size.width/CGFloat(width) //brick width
        var xPos : CGFloat = 0
        var yPos : CGFloat = 0
        for row in 0..<length {
            
            board.append([])
            
            for _ in 0..<width {
                let obstacleBool = obstacles.contains(count) ? true : false
                let goalBool = goal == count ? true : false
                let newSquare = BoardSquare(position: count, isObstacle: obstacleBool, isGoal: goalBool)
                count += 1
                newSquare.image.image = resize(newSquare.image.image!, newWidth: w)
                newSquare.image.frame = CGRectMake(xPos, yPos, w, w)
                newSquare.center = (xPos: xPos - w/2, yPos: yPos - w/2)
                
                board[row].append(newSquare)
                
                xPos += w
                view.addSubview(newSquare.image)
            }
            yPos += w
            xPos = 0
        }
        
        // set up the player
        playerCell = board[0][0]
        player = MyObject(center: playerCell.image.center, width: CGFloat(playerCell.image.frame.width / 2))
        view.addSubview(player)
        view.bringSubviewToFront(player)
    }
    
    //=========================================================
    // Handles resizing an image
    //=========================================================
    func resize(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
