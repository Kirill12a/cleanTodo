//
//  ListTasksPresenter.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//

import UIKit

protocol ListTasksPresentationLogic {
    func presentFetchFromDataStoreResult(with response: ListTasksModels.FetchFromDataStore.Response)
    func presentSelectTaskResult(with response: ListTasksModels.SelectTask.Response)
}

class ListTasksPresenter: ListTasksPresentationLogic {
    weak var viewController: ListTasksDisplayLogic?
    
    // MARK: Fetch Data From DataStore
    
    func presentFetchFromDataStoreResult(with response: ListTasksModels.FetchFromDataStore.Response) {
        let viewModel = ListTasksModels.FetchFromDataStore.ViewModel(tasks: response.tasks)
        viewController?.displayFetchFromDataStoreResult(with: viewModel)
    }  
    
    // MARK: Use Case - Select Task
    
    func presentSelectTaskResult(with response: ListTasksModels.SelectTask.Response) {
        let viewModel = ListTasksModels.SelectTask.ViewModel(tasks: response.tasks)
        viewController?.displaySelectTaskResult(with: viewModel)
    }
}
