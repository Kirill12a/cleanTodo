//
//  ListTasksModels.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//


import UIKit

enum ListTasksModels {
    
    // MARK: Data Store Fetch
    
    enum FetchFromDataStore {
        struct Request {
        }
        
        struct Response {
            var tasks: [String]
        }
        
        struct ViewModel {
            var tasks: [String]
        }
    }
    
    // MARK: Use Cases
    
    enum SelectTask {
        struct Request {
            var task: String?
        }
        
        struct Response {
            var tasks: [String]
        }
        
        struct ViewModel {
            var tasks: [String]
        }
    }
}
