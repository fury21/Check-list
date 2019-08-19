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
        createAlertController(title: "Новый список", message: "Введите имя нового списка")
    }
    
    @IBAction func editingButtonPressed() {
        tableView.isEditing.toggle()
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
    private func createAlertController(title: String, message: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // Добавляю текстовое поле
        alert.addTextField { (textField) in
            textField.placeholder = "Укажите название"
        }
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            if let taskNameTextField =  alert.textFields?.first?.text,
                !taskNameTextField.isEmpty {
                
                let newList = AllLists(listName: taskNameTextField, items: [])
                allLists.append(newList)
                self.tableView.reloadData()
                
            } else {
                let alert = DefaultAlert.createDefaultAlert(title: "Ошибка", message: "Введена пустая строка")
                self.present(alert, animated: true, completion: nil)
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
