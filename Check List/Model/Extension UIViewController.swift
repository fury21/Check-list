//
//  Extension UIViewController.swift
//  Check List
//
//  Created by Viktor on 17/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

var sortTasks: [Tasks] = []


extension UIViewController {
    
    
    func sortByAlphabet(by tasks: [Tasks]) -> [Tasks] {
        let sortedTasks = tasks.sorted(by: {$0.taskName > $1.taskName})
        return sortedTasks
    }
    
    func executionSort(by tasks: [Tasks]) -> [Tasks] {
        let tasks = tasks.sorted(by: { $0.isTaskDone && !$1.isTaskDone })
        return tasks
    }
    
    func showSortAlert(for tasks: [Tasks]) {
        
        let alert = UIAlertController(title: "Сортировка",
                                      message: "Отсортируйте ваш список",
                                      preferredStyle: .alert)
        
        alert.view.tintColor = #colorLiteral(red: 1, green: 0.8196527362, blue: 0.4653458595, alpha: 1)
        
        let sortByAlphabetAction = UIAlertAction(title: "По алфавиту",
                                                 style: .default) { (_) in
                                                    sortTasks = self.sortByAlphabet(by: tasks)
                                                    
        }
        
        let sortByExecutionAction = UIAlertAction(title: "По выполнению",
                                                  style: .default) { (_) in
                                                   sortTasks = self.executionSort(by: tasks)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(sortByAlphabetAction)
        alert.addAction(sortByExecutionAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func executionCheck(for tasks: [Tasks]) -> Bool {
        var currentStatTaskList = false
        for task in tasks {
            if task.isTaskDone == true {
                currentStatTaskList = true
            } else {
                currentStatTaskList = false
            }
        }
    return currentStatTaskList
    }
}

