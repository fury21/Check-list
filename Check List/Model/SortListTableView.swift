//
//  SortListTableView.swift
//  Check List
//
//  Created by Александр Б. on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import Foundation

func sortList() {
    
}

class AllLists {
    
    var listName: String
    var items: [Tasks]
    var isListDone = false
    static var itemsCout = 0
    
    init(listName: String, items: [Tasks]) {
        self.listName = listName
        self.items = items
        self.isListDone = false
        AllLists.itemsCout += 1
    }
}

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

var allLists = [AllLists]()


//let userDefaults = UserDefaults.standard
//userDefaults.set(email, forKey: "login")
//
//
////-------
//let userDefaultsGet = UserDefaults.standard
//
//guard userDefaultsGet.object(forKey: "login") as? String != nil else {
//    showAlert(title: "ОШИБКА!", message: "Вы еще не зарегестрированы")
//    return
//}
//
//
//let email = userDefaultsGet.object(forKey: "login") as! String
//let password = userDefaultsGet.object(forKey: "password") as! String
