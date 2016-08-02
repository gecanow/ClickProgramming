//
//  ViewController.swift
//  Click
//
//  Created by Diva Harsoor on 7/29/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

//***********************//
// ADD ACTION TYPES HERE //
//***********************//
enum ActionType {
    case Move
    case Turn
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var simulator: UIView!
    
    var functions : [ActionCell] = []
    
    var board = Board(width: 6, length: 9)
    
    enum ReturnOption {
        case Move
        case Turn
    }
    
    //=================================================
    // VIEW DID LOAD FUNCTION
    //=================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        board.loadBoard(simulator)
    }
    
    //=================================================
    // VIEW WILL APPEAR FUNCTION
    //=================================================
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //=================================================
    // Handles converting the code to the player's
    // actions:
    // Current actions include Move and Turn
    //=================================================
    @IBAction func onTappedRunCode(sender: UIButton) {
        
        board.player.reset()
        
        var count = 0.0
        
        for action in functions {
            
            if action.type == .Move {
                
                let cellAmount = Double((action.myButton.titleLabel?.text)!)
                let widthPerCell = Double(board.board[0][0].image.frame.width)
                
                board.player.distance = cellAmount! * widthPerCell
                
                NSTimer.scheduledTimerWithTimeInterval(count, target: board.player, selector: #selector(board.player.moveForward), userInfo: nil, repeats: false)
                
                count += 2.0
                
            } else if action.type == .Turn {
                
                board.player.direction = (action.myButton.titleLabel?.text)!
                NSTimer.scheduledTimerWithTimeInterval(count, target: board.player, selector: #selector(board.player.turn), userInfo: nil, repeats: false)
                
            } else {}
            
        }
    }
    
    //=================================================
    // SETUP & UPDATE THE TABLEVIEW
    //=================================================
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.textColor = UIColor.grayColor()
        
        if functions[indexPath.row].isMutable {
            cell.contentView.addSubview(functions[indexPath.row].myLabel)
            cell.contentView.addSubview(functions[indexPath.row].myButton)
        } else {
            cell.contentView.addSubview(functions[indexPath.row].myLabel)
            cell.userInteractionEnabled = false
        }
        
        return cell
    }
    
    //=================================================
    // ALLOW FOR FUNCTIONS TO BE DELETED
    //=================================================
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            functions.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    //=================================================
    // ALLOW FOR FUNCTIONS TO BE ADDED
    //=================================================
    @IBAction func onTappedAddAction(sender: UIButton) {
        //Action Sheet
        let actionController = UIAlertController(title: "Select an option.", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let moveAction = UIAlertAction(title: "Move ()", style: .Default) { (action) in
            self.functions.append(ActionCell(name: "Move Forward: ", type: .Move, color: UIColor.greenColor(), buttonText: "0"))
            self.tableView.reloadData()
        }
        
        let turnToFaceAction = UIAlertAction(title: "Turn ()", style: .Default) { (action) in
            self.functions.append(ActionCell(name: "Turn To Face: ", type: .Turn, color: UIColor.blueColor(), buttonText: "East"))
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionController.addAction(moveAction)
        actionController.addAction(turnToFaceAction)
        actionController.addAction(cancelAction)
        
        self.presentViewController(actionController, animated: true, completion: nil)
    }
    
    //=================================================
    // ALLOW FOR ROWS TO BE MOVED
    //=================================================
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let function = functions[sourceIndexPath.row]
        functions.removeAtIndex(sourceIndexPath.row)
        functions.insert(function, atIndex: destinationIndexPath.row)
    }
    
    @IBAction func onTappedEdit(sender: UIButton) {
        if sender.tag == 0 {
            tableView.editing = true
            sender.tag = 1
        } else {
            tableView.editing = false
            sender.tag = 0
        }
    }
}

