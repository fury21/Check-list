//
//  ListsTableViewController.swift
//  Check List
//
//  Created by Александр Б. on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

class ListsUIViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func newListButton() {
        createAlertController(title: "Новый список",
                              message: "Введите имя нового списка",
                              actionTitle: "Добавить",
                              type: .add)
    }
    
    @IBAction func editingButtonPressed() {
        if allLists.count > 0 {
        tableView.isEditing.toggle()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let taskVC = segue.destination as! TasksUIViewController
            
            taskVC.currentIndexPath = indexPath
        }
    }
    
    //Создание алерта для добавления нового элемента
    private func createAlertController(title: String,
                                       message: String,
                                       actionTitle: String,
                                       type: AlertType,
                                       index: Int = 0) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // Добавляю текстовое поле
        alert.addTextField { (textField) in
            textField.placeholder = "Укажите название"
            if type == .edit {
                textField.text = allLists[index].listName
            }
        }
        
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            if let taskNameTextField =  alert.textFields?.first?.text,
                !taskNameTextField.isEmpty {
                let newList = AllLists(listName: taskNameTextField, items: [])
                
                switch type {
                case .add:
                    allLists.append(newList)
                case .edit:
                    allLists[index] = newList
                }
                
                self.tableView.reloadData()
            } else {
                self.showAlert(title: "Ошибка", message: "Введена пустая строка")
            }
        }
        
        alert.view.tintColor = #colorLiteral(red: 1, green: 0.8196527362, blue: 0.4653458595, alpha: 1)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension ListsUIViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        
        cell.detailTextLabel?.text = "\(allLists[indexPath.row].items.count)\\\(allLists[indexPath.row].items.filter { $0.isTaskDone == true }.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editing = editingAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, editing])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "delete") { (_, action, completion) in
            allLists.remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        action.image = UIImage(named: "Trash")
        action.backgroundColor = .red
        return action
    }
    
    func editingAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "editing") { (_, action, completion) in
            self.createAlertController(title: "Редактирование",
                                       message: "Редактирование имени списка",
                                       actionTitle: "Изменить",
                                       type: .edit,
                                       index: indexPath.row)
        }
        action.image = UIImage(named: "edit")
        action.backgroundColor = .gray
        return action
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentTask = allLists.remove(at: sourceIndexPath.row)
        allLists.insert(currentTask, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}
