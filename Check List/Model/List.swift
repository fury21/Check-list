//
//  AllLists.swift
//  Check List
//
//  Created by Александр Б. on 16/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import Foundation

class List {
    
    let listName: String
    var items: [Task]
    var isListDone = false
    
    init(listName: String, items: [Task]) {
        self.listName = listName
        self.items = items
        self.isListDone = false
    }
}

var allLists = [List]()
