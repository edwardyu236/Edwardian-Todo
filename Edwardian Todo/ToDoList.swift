//
//  TodoList.swift
//  Edwardian Todo
//
//  Created by Edward Yu on 19/09/2015.
//  Copyright © 2015 Edward Yu. All rights reserved.
//

import Foundation

class TodoList {
    var todos = [String]()
    var todoCompleted = [Bool]()
    
    func addTodo(todo: String) {
        todos.append(todo)
        todoCompleted.append(false)
    }
    
    func demo() {
        self.addTodo("Finish coding Edwardian Todo.")
        self.addTodo("Be awesome!")
        self.setCompletedAtIndex(1)
    }
    
    func count() -> Int {
        return todos.count
    }
    
    func getTodoAtIndex(index: Int) -> String {
        return todos[index]
    }
    
    func isCompletedAtIndex(index: Int) -> Bool {
        return todoCompleted[index]
    }
    
    func setCompletedAtIndex(index: Int) {
        todoCompleted[index] = true
    }
    
    func setIncompleteAtIndex(index: Int) {
        todoCompleted[index] = false
    }
    
    func removeAtIndex(index: Int) {
        todos.removeAtIndex(index)
        todoCompleted.removeAtIndex(index)
    }
    
}