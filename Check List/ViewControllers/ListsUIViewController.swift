//
//  ListsTableViewController.swift
//  Check List
//
//  Created by Александр Б. on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

class ListsUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func newListButton(_ sender: Any) {
        allLists.append(AllLists(listName: "Новый список", items: []))
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        
        let currentStatTaskList = executionCheck(for: allLists[indexPath.row].items)
        
        if currentStatTaskList == true && !allLists[indexPath.row].items.isEmpty {
            cell.listLabel.attributedText = allLists[indexPath.row].listName.strikeThrough()
            cell.backgroundColor = #colorLiteral(red: 0.6940407753, green: 0.6941619515, blue: 0.6940331459, alpha: 1)
        } else {
            cell.listLabel.attributedText = allLists[indexPath.row].listName.cancelStrikeThrough()
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        return cell
    }    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let taskVC = segue.destination as! TasksUIViewController
            
            taskVC.currentIndexPath = indexPath
        }
    }
}
