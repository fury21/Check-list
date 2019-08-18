//
//  SaveAndRestoreList.swift
//  Check List
//
//  Created by Александр Б. on 18/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import Foundation

func saveAllList() {
    let defaults = UserDefaults.standard
    defaults.set(allLists, forKey: "SavedList")
}

func restoreAllList() {
    let defaults = UserDefaults.standard
    allLists = defaults.object(forKey: "SavedList") as? [AllLists] ?? [AllLists]()
    
}


