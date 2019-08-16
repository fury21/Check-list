//
//  AllLists.swift
//  Check List
//
//  Created by Александр Б. on 16/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import Foundation

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

var allLists = [AllLists]()
