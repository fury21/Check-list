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
    private var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = task.title
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.taskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = task.taskList[indexPath.row].taskList
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: зачеркивание текста
        task.taskList[indexPath.row].isDone.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Удаление ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            task.taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentTask = task.taskList.remove(at: sourceIndexPath.row)
        task.taskList.insert(currentTask, at: destinationIndexPath.row)
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
            let newTaskList = TaskList(taskList: text, isDone: false)
            self.task.taskList.append(newTaskList)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
