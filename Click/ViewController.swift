//
//  ViewController.swift
//  Click
//
//  Created by Diva Harsoor on 7/29/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var functions : [ActionCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //=================================================
    // SETUP & UPDATE THE TABLEVIEW
    //=================================================
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "\(functions[indexPath.row].name) \(indexPath.row)"
        
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
        
        // first i call on the action sheet which returns a string to me
        let actionStr = ""
        
        functions.append(ActionCell(name: actionStr))
        tableView.reloadData()
        
    }
    
    //=================================================
    // ALLOW FOR ROWS TO BE MOVED
    //=================================================
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
      //  let city = cities[sourceIndexPath.row]
        //cities.removeAtIndex(sourceIndexPath.row)
        //cities.insert(city, atIndex: destinationIndexPath.row)
    //}
    
    
    
}

