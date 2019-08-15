//
//  TaskList.swift
//  Check List
//
//  Created by Viktor on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

class AllLists {
    
    var listName: String
    var items: [Task]
    static var itemsCout = 0
    
    var isListDone = false
    
    init(listName: String, items: [Task], isListDone: Bool) {
        self.listName = listName
        self.items = items
        self.isListDone = isListDone
        AllLists.itemsCout += 1
        print("Кол-во всех списков: \(AllLists.itemsCout)")
    }
    
    deinit {
        AllLists.itemsCout -= 1
        print("Кол-во всех списков: \(AllLists.itemsCout)")
    }
}
