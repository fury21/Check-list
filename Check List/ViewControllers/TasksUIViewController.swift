//
//  TasksTableViewController.swift
//  Check List
//
//  Created by Александр Б. on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

// В зависимости от этого значения алерт принимает один из видов(редактирование или добавление)
enum AlertType {
    case edit
    case add
}

class TasksUIViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    // IndexPath для работы с массивом в глобальной облости видимости
    var currentIndexPath: IndexPath!
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barBtnVar = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addButton))
        navigationItem.setRightBarButton(barBtnVar, animated: true)
        navigationItem.title = allLists[currentIndexPath.row].listName
        
        refresh.addTarget(self,
                          action: #selector(handleRefresh),
                          for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    
    // кнопка edit
    @IBAction func editTable() {
        tableView.isEditing.toggle()
    }
    
    
    @IBAction func sortButton() {
        showSortAlert()
    }
    
    // MARK: - Table view data source
    @objc func addButton() {
        createAlertController(title: "Добавление",
                              message: "Введите новую задачу",
                              actionTitle: "Добавить",
                              type: .add)
    }
    
    func showSortAlert() {
        let alert = UIAlertController(title: "Сортировка",
                                      message: "Отсортируйте ваш список",
                                      preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 1, green: 0.8196527362, blue: 0.4653458595, alpha: 1)
        let sortByAlphabetAction = UIAlertAction(title: "По алфавиту",
                                                 style: .default) { (_) in
                                                    self.sortByAlphabet(indexPath: self.currentIndexPath)
                                                    self.tableView.reloadData()
        }
        let sortByExecutionAction = UIAlertAction(title: "По выполнению",
                                                  style: .default) { (_) in
                                                    self.sortByDone(indexPath: self.currentIndexPath)
                                                    self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(sortByAlphabetAction)
        alert.addAction(sortByExecutionAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //action refresh таблицы, сбрасывает все выбранные элементы
    @objc private func handleRefresh() {
        refresh.endRefreshing()
        for item in allLists[currentIndexPath.row].items {
            if item.isTaskDone {
                item.isTaskDone.toggle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            self.tableView.reloadData()
        }
    }
    
    //Создание алерта для добавления нового элемента
    private func createAlertController(title: String, message: String,
                                       actionTitle: String, type: AlertType, index: Int = 0) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // Добавляю первое текстовое поле
        alert.addTextField { (textField) in
            switch type {
            case .add:
                textField.placeholder = "Укажите название"
            case .edit:
                textField.text = allLists[self.currentIndexPath.row].items[index].taskName
            }
        }
        
        // Добавляю второе текстовое поле
        alert.addTextField { (textField) in
            switch type {
            case .add:
                textField.placeholder = "Укажите количество"
                textField.keyboardType = .numberPad
            case .edit:
                textField.text = "\(allLists[self.currentIndexPath.row].items[index].tasksCount)"
            }
        }
        
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            if let taskNameTextField =  alert.textFields?.first?.text,
                !taskNameTextField.isEmpty, let taskCountTextField = alert.textFields?[1].text,
                let taskCount = Int(taskCountTextField) {
                
                let newTaskList = Tasks(taskName: taskNameTextField, tasksCount: taskCount)
                switch type {
                case .add:
                    allLists[self.currentIndexPath.row].items.append(newTaskList)
                case .edit:
                    allLists[self.currentIndexPath.row].items[index] = newTaskList
                }
                self.tableView.reloadData()
            } else {
                self.showAlert(title: "Ошибка", message: "Некорректный ввод")
            }
        }
        
        alert.view.tintColor = #colorLiteral(red: 1, green: 0.8196527362, blue: 0.4653458595, alpha: 1)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
}

// Работа с tableView
extension TasksUIViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentTask = allLists[currentIndexPath.row].items.remove(at: sourceIndexPath.row)
        allLists[currentIndexPath.row].items.insert(currentTask, at: destinationIndexPath.row)
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLists[currentIndexPath.row].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let currentState = allLists[currentIndexPath.row].items[indexPath.row].isTaskDone
        
        if currentState == true {
            cell.textLabel?.attributedText = allLists[currentIndexPath.row].items[indexPath.row].taskName.strikeThrough()
            cell.backgroundColor = #colorLiteral(red: 0.6940407753, green: 0.6941619515, blue: 0.6940331459, alpha: 1)
        } else {
            cell.textLabel?.attributedText = allLists[currentIndexPath.row].items[indexPath.row].taskName.cancelStrikeThrough()
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        cell.detailTextLabel?.text = "\(allLists[currentIndexPath.row].items[indexPath.row].tasksCount)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let currentState = allLists[currentIndexPath.row].items[indexPath.row].isTaskDone
        
        if currentState == false {
            cell.textLabel?.attributedText = allLists[currentIndexPath.row].items[indexPath.row].taskName.strikeThrough()
            cell.backgroundColor = #colorLiteral(red: 0.6940407753, green: 0.6941619515, blue: 0.6940331459, alpha: 1)
        } else {
            cell.textLabel?.attributedText = allLists[currentIndexPath.row].items[indexPath.row].taskName.cancelStrikeThrough()
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        allLists[currentIndexPath.row].items[indexPath.row].isTaskDone.toggle()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allLists[indexPath.row].items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
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
        action.image = UIImage(named: "edit")
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
}
