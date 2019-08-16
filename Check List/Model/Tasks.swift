//
//  Tasks.swift
//  Check List
//
//  Created by Александр Б. on 16/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import Foundation

class Tasks {
    
    let taskName: String
    var isTaskDone = false
    var tasksCount: Int
    
    init(taskName: String, tasksCount: Int) {
        self.taskName = taskName
        self.isTaskDone = false
        self.tasksCount = tasksCount
    }
}
