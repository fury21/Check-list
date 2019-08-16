//
//  TasksTableViewController.swift
//  Check List
//
//  Created by Александр Б. on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

enum AlertType {
    case edit
    case add
}

class TasksUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var tasks: [Tasks]!
    var currentIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let barBtnVar = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
//        navigationItem.setRightBarButton(barBtnVar, animated: true)
    }

    // MARK: - Table view data source
    @IBAction func addButton() {
        createAlertController(title: "Добавление",
                              message: "Введите новую задачу",
                              actionTitle: "Добавить",
                              type: .add)
    }
    
    // кнопка edit
    @IBAction func etidTable() {
        tableView.isEditing.toggle()
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLists[currentIndexPath.row].items.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskLabel.text = allLists[currentIndexPath.row].items[indexPath.row].taskName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let important = importantAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete, important])
    }
    
    func importantAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Editing") { (_, action, completion) in
            self.createAlertController(title: "Редактирование",
                                       message: "Редактирование задачи",
                                       actionTitle: "Сохранить",
                                       type: .edit,
                                       index: indexPath.row)
        }
        action.image = UIImage(named: "Alarm")
        action.backgroundColor = .gray
        
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive , title: "Delete") { (_, action, completion) in
            allLists[self.currentIndexPath.row].items.remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        action.image = UIImage(named: "Trash")
        action.backgroundColor = .red
        
        return action
    }
    
    private func createAlertController(title: String, message: String,
                                       actionTitle: String, type: AlertType, index: Int = 0) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // Добавляю первое текстовое поле
        alert.addTextField { (textField) in
            switch type {
            case .add:
                textField.placeholder = "enter something..."
            case .edit:
                textField.text = allLists[self.currentIndexPath.row].items[index].taskName
            }
        }
        
        // Добавляю второе текстовое поле
        alert.addTextField { (textField) in
            switch type {
            case .add:
                textField.placeholder = "enter something..."
            case .edit:
                textField.text = String(allLists[self.currentIndexPath.row].items[index].tasksCount)
            }
        }
        
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            guard let taskNameTextField =  alert.textFields?.first?.text,
                !taskNameTextField.isEmpty, let taskCountTextField = alert.textFields?[1].text,
                let taskCount = Int(taskCountTextField) else {return}
            
            let newTaskList = Tasks(taskName: taskNameTextField, tasksCount: taskCount)
            switch type {
            case .add:
                allLists[self.currentIndexPath.row].items.append(newTaskList)
            case .edit:
                allLists[self.currentIndexPath.row].items[index] = newTaskList
            }
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
