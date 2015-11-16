//
//  TodoList.swift
//  Edwardian Todo
//
//  Created by Edward Yu on 19/09/2015.
//  Copyright © 2015 Edward Yu. All rights reserved.
//

import Foundation

class TodoList : NSObject, NSCoding {
    
    var todos: [String]
    var todosCompleted: [Bool]
    struct PropertyKey {
        static let todosCount = "todosCount"

    }

    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("todoList")
    
    init(todos: [String], todosCompleted: [Bool]) {
        self.todos = todos
        self.todosCompleted = todosCompleted
        super.init()
    }
    
    convenience override init() {
        self.init(todos: [String](), todosCompleted: [Bool]())
    }
    
    func addTodo(todo: String) {
        todos.append(todo)
        todosCompleted.append(false)
    }
    
    func demo() {
        self.addTodo("Finish coding Edwardian Todo.")
        self.addTodo("Be awesome!")
        self.setCompletedAtIndex(todos.count - 1)
    }
    
    func count() -> Int {
        return todos.count
    }
    
    func getTodoAtIndex(index: Int) -> String {
        return todos[index]
    }
    
    func isCompletedAtIndex(index: Int) -> Bool {
        return todosCompleted[index]
    }
    
    func setCompletedAtIndex(index: Int) {
        todosCompleted[index] = true
    }
    
    func setIncompleteAtIndex(index: Int) {
        todosCompleted[index] = false
    }
    
    func removeAtIndex(index: Int) {
        todos.removeAtIndex(index)
        todosCompleted.removeAtIndex(index)
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(todos.count, forKey: PropertyKey.todosCount)
        for i in 0..<todos.count {
            aCoder.encodeObject(todos[i])
        }
        for i in 0..<todos.count {
            aCoder.encodeObject(todosCompleted[i])
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let count = aDecoder.decodeIntegerForKey(PropertyKey.todosCount)
        if count == 0 {
            // Just set up a new list
            self.init()
        } else {
            // Have data, read it in
            var todos = [String]()
            for _ in 0..<count {
                if let todo = aDecoder.decodeObject() as? String {
                    todos.append(todo)
                }
            }
            
            var todosCompleted = [Bool]()
            for _ in 0..<count {
                if let todoCompleted = aDecoder.decodeObject() as? Bool {
                    todosCompleted.append(todoCompleted)
                }
            }
            
            self.init(todos: todos, todosCompleted: todosCompleted)
        }
    }
    
}