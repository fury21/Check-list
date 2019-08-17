//
//  Extension UIViewController.swift
//  Check List
//
//  Created by Viktor on 17/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func sortByAlphabet(by tasks: [Tasks]) -> [Tasks] {
        let sortedTasks = tasks.sorted(by: {$0.taskName > $1.taskName})
        return sortedTasks
    }

    func executionSort(by tasks: [Tasks]) -> [Tasks] {
        let tasks = tasks.sorted(by: { $0.isTaskDone && !$1.isTaskDone })
        return tasks
    }

    
}
