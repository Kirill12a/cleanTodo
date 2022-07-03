//
//  ListTasksRouter.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//

import UIKit

protocol ListTasksRoutingLogic {
    func routeToSomewhere()
    func testHelloWorkd()
}

protocol ListTasksDataPassing {
    var dataStore: ListTasksDataStore? { get }
}

class ListTasksRouter: NSObject, ListTasksRoutingLogic, ListTasksDataPassing {
    var viewController: ListTasksViewController?
    var dataStore: ListTasksDataStore?
    
    // MARK: Routing
    
    func routeToSomewhere() {
        routeToSomewhere(segue: nil)
    }

    func testHelloWorkd() {
        print("hEllorouteToSomewhere")
    }
    
    func routeToSomewhere(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ListTasksViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataTo(&destinationDS, from: dataStore!)
        } else {
            let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SomewhereViewController") as! ListTasksViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataTo(&destinationDS, from: dataStore!)
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    // MARK: Data Passing
    
    func passDataTo(_ destinationDS: inout ListTasksDataStore, from sourceDS: ListTasksDataStore) {
        //destinationDS.attribute = sourceDS.attribute
    }
}
