//
//  ViewController.swift
//  Edwardian Todo
//
//  Created by Edward Yu on 18/09/2015.
//  Copyright © 2015 Edward Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todolist = TodoList()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // deal with table view

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let todoListIndex = indexPath.row

        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = todolist.getTodoAtIndex(todoListIndex)
        
        if todolist.isCompletedAtIndex(todoListIndex) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let todoListIndex = indexPath.row
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            self.todolist.removeAtIndex(todoListIndex)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        let duplicateAction = UITableViewRowAction(style: .Default, title: "Duplicate") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            let temp = self.todolist.getTodoAtIndex(todoListIndex)
            self.todolist.addTodo(temp)
            let duplicateIndex = self.todolist.count() - 1
            if self.todolist.isCompletedAtIndex(todoListIndex) {
                self.todolist.setCompletedAtIndex(duplicateIndex)
            } else {
                self.todolist.setIncompleteAtIndex(duplicateIndex)
            }
            tableView.reloadData()
        }
        duplicateAction.backgroundColor = UIColor.blueColor()

        
        return [deleteAction, duplicateAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let todoListIndex = indexPath.row
        if todolist.isCompletedAtIndex(todoListIndex) {
            self.todolist.setIncompleteAtIndex(todoListIndex)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .None
        } else {
            self.todolist.setCompletedAtIndex(todoListIndex)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark

        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // Deal with buttons on bar
    @IBAction func createNew(sender: UIButton) {
        var todoField = UITextField()
        
        let prompt = UIAlertController(title: "Create a new to-do", message: nil, preferredStyle: .Alert)
        
        prompt.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "Title of To-Do"
            todoField = textField
        }
        
        prompt.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        prompt.addAction(UIAlertAction(title: "Create", style: .Default) {
            (action: UIAlertAction) -> Void in
            let todo = todoField.text!
            if todo != "" {
                self.todolist.addTodo(todo)
                
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.todolist.count() - 1, inSection: 0)], withRowAnimation: .Fade)
            }
            
        })
        self.presentViewController(prompt, animated: true, completion: nil)

    }

    @IBAction func deleteAll(sender: UIButton) {
        let confirmation = UIAlertController(title: "Delete all?", message: "This action is not reversible. Are you sure you want to delete all?", preferredStyle: .Alert)
        confirmation.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        confirmation.addAction(UIAlertAction(title: "Delete", style: .Destructive) {
            (action: UIAlertAction) -> Void in
            self.todolist = TodoList()
            self.tableView.reloadData()
            })
        self.presentViewController(confirmation, animated: true, completion: nil)

    }
    
    @IBAction func demo(sender: UIButton) {
        todolist.demo()
        self.tableView.reloadData()
    }

}

