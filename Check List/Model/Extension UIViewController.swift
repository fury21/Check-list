//
//  Extension UIViewController.swift
//  Check List
//
//  Created by Viktor on 17/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func sortByAlphabet(indexPath: IndexPath) {
        allLists[indexPath.row].items.sort(by: {$0.taskName < $1.taskName})
    }
    
    func sortByDone(indexPath: IndexPath) {
        allLists[indexPath.row].items.sort(by: { !$0.isTaskDone && $1.isTaskDone })
    }
    
    func executionCheck(for tasks: [Task]) -> Bool {
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
    
    func showAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = #colorLiteral(red: 1, green: 0.8196527362, blue: 0.4653458595, alpha: 1)
        present(alert, animated: true)
    }
}
