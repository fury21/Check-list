////
////  ListTableViewController.swift
////  Check List
////
////  Created by Роман Важник on 15/08/2019.
////  Copyright © 2019 Александр Б. All rights reserved.
////
//
//import UIKit
//
//class ListTableViewController: UITableViewController {
//
//    // По тапу на ячейку передаем наш список сюда
//    fileprivate var task: Tasks!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return task.taskList.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
//        cell.textLabel?.text = task.taskList[indexPath.row].taskList
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // TODO: зачеркивание текста
//        task.taskList[indexPath.row].isDone.toggle()
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    // Удаление ячейки
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            task.taskList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)
//        }
//    }
//
//    // Запуск при нажатии на копку редактирования
//    @IBAction func etidTable() {
//        tableView.isEditing.toggle()
//    }
//
//}
