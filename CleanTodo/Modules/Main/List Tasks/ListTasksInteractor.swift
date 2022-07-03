//
//  ListTasksInteractor.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//

import UIKit

protocol ListTasksBusinessLogic {
    func fetchFromDataStore(with request: ListTasksModels.FetchFromDataStore.Request)
    func selectTask(with request: ListTasksModels.SelectTask.Request)
}

protocol ListTasksDataStore {
    var tasks: [String]? { get set }
}

class ListTasksInteractor: ListTasksBusinessLogic, ListTasksDataStore {
    var worker: ListTasksWorker? = ListTasksWorker()
    var presenter: ListTasksPresentationLogic?
    var tasks: [String]?
    
    // MARK: Fetch Data From DataStore
    
    func fetchFromDataStore(with request: ListTasksModels.FetchFromDataStore.Request) {
        tasks = worker?.fetchFromDataStore()
        let response = ListTasksModels.FetchFromDataStore.Response(tasks: tasks!)
        presenter?.presentFetchFromDataStoreResult(with: response)
    }
    
    // MARK: Use Case - Select Task
    
    func selectTask(with request: ListTasksModels.SelectTask.Request) {
        guard let task = request.task, let tasksList = tasks else { return }
        
        tasks = worker?.removeTask(task, from: tasksList)
        
        let response = ListTasksModels.SelectTask.Response(tasks: tasks!)
        presenter?.presentSelectTaskResult(with: response)
    }
}
