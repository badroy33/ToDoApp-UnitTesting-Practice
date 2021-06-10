//
//  TaskManger.swift
//  ToDoApp
//
//  Created by Maksym Levytskyi on 05.06.2021.
//

import UIKit

class TaskManager {
    var tasks: [Task] = []
    var doneTasks: [Task] = []
    var tasksCount: Int{
        return tasks.count
    }
    var doneTasksCount: Int{
        doneTasks.count
    }
    
    func addTask(task: Task){
        if !tasks.contains(task){
            tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task{
         return tasks[index]
    }
    
    func checkTask(at index: Int){
        let removedTask = tasks.remove(at: index)
        doneTasks.append(removedTask)
    }
    
    func uncheckTask(at index: Int){
        let removedTask = doneTasks.remove(at: index)
        tasks.append(removedTask)
    }
    
    func doneTask(at index: Int) -> Task{
        return doneTasks[index]
    }
    
    func removeAll(){
        tasks.removeAll()
        doneTasks.removeAll()
    }
}

