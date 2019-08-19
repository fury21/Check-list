//
//  Extension UIViewController.swift
//  Check List
//
//  Created by Viktor on 17/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

//var sortTasks: [Tasks] = []

enum KindOfSort {
    case alphabet
    case execution
}

var kindOfSort = KindOfSort.alphabet

extension UIViewController {
    
    
    func sortByAlphabet(by tasks: [Tasks]) -> [Tasks] {
        let sortedTasks = tasks.sorted(by: {$0.taskName < $1.taskName})
        return sortedTasks
    }
    
    func executionSort(by tasks: [Tasks]) -> [Tasks] {
        let tasks = tasks.sorted(by: { !$0.isTaskDone && $1.isTaskDone })
        return tasks
    }
    
    func executionCheck(for tasks: [Tasks]) -> Bool {
        var execution: [Bool] = []
        var currentStatTaskList = false
        for task in tasks {
            if task.isTaskDone == false {
                execution.append(false)
            }
        }
        if execution.isEmpty {
            currentStatTaskList = true
        }
        return currentStatTaskList
    }
}

