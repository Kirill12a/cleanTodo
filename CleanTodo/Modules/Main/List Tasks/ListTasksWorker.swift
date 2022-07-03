//
//  ListTasksWorker.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//

import UIKit

class ListTasksWorker {
    func fetchFromDataStore() -> [String] {
        return ["Task 1", "Task 2"]
    }
    
    func removeTask(_ task: String, from taskList: [String]) -> [String] {
        guard let index = taskList.index(of: task) else { return taskList }
        
        var tasks = taskList
        tasks.remove(at: index)
        return tasks
    }
}
