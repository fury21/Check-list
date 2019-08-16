//
//  Task.swift
//  Check List
//
//  Created by Viktor on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

class Task {
    
    let taskName: String
    var tasksCount: Int
    
    var isTaskDone = false
    
    init(taskName: String, isTaskDone: Bool, tasksCount: Int) {
        self.taskName = taskName
        self.isTaskDone = isTaskDone
        self.tasksCount = tasksCount
    }
}
