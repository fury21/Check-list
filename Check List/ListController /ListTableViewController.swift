//
//  ListTableViewController.swift
//  Check List
//
//  Created by Роман Важник on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // По тапу на ячейку передаем наш список сюда
    private var task: AllLists!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = task.listName
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = task.items[indexPath.row].taskName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: зачеркивание текста
        task.items[indexPath.row].isTaskDone.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Удаление ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            task.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentTask = task.items.remove(at: sourceIndexPath.row)
        task.items.insert(currentTask, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    // кнопка add
    @IBAction func addButtonPressed() {
        createAlertController()
    }
    
    // кнопка edit
    @IBAction func etidTable() {
        tableView.isEditing.toggle()
    }
    
    fileprivate func createAlertController() {
        let alert = UIAlertController(title: "Добавление",
                                      message: "Введите сюда то, что хотите добавить в списов",
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "enter something..."
        }
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            guard let text =  alert.textFields?.first?.text, !text.isEmpty else  {return}
            let newTaskList = Task(taskName: text, isTaskDone: false, tasksCount: 3)
            self.task.items.append(newTaskList)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
