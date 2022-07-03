//
//  ListTasksViewController.swift
//  CleanSwift
//
//  Created by Kirill Drozdov on 02.07.2022.
//

import UIKit

protocol ListTasksDisplayLogic: class {
    func displayFetchFromDataStoreResult(with viewModel: ListTasksModels.FetchFromDataStore.ViewModel)
    func displaySelectTaskResult(with viewModel: ListTasksModels.SelectTask.ViewModel)
}

class ListTasksViewController: UIViewController, ListTasksDisplayLogic {
    
    // MARK: Properties
    
    var router: (NSObjectProtocol & ListTasksRoutingLogic & ListTasksDataPassing )?
    var interactor: ListTasksBusinessLogic?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ListTasksInteractor()
        let presenter = ListTasksPresenter()
        let router = ListTasksRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFetchFromDataStore()
        router?.testHelloWorkd()
    }
    
    // MARK: TableView
    
    @IBOutlet var listTaskTV: UITableView!
    func setupTableView() {
        listTaskTV.delegate = self
        listTaskTV.dataSource = self
        listTaskTV.tableFooterView = UIView()
    }
    
    // MARK: Fetch Data From DataStore
    
    var tasks: [String]?
    @IBOutlet var taskCountLabel: UILabel!
    func setupFetchFromDataStore() {
        let request = ListTasksModels.FetchFromDataStore.Request()
        interactor?.fetchFromDataStore(with: request)
    }
    
    func displayFetchFromDataStoreResult(with viewModel: ListTasksModels.FetchFromDataStore.ViewModel) {
        tasks = viewModel.tasks
        taskCountLabel.text = "\(tasks!.count)"
        listTaskTV.reloadData()
    }
    
    // MARK: Use Case - Select Task
    
    func selectTask(_ item: Int) {
        let request = ListTasksModels.SelectTask.Request(task: tasks![item])
        interactor?.selectTask(with: request)
    }
    
    func displaySelectTaskResult(with viewModel: ListTasksModels.SelectTask.ViewModel) {
        tasks = viewModel.tasks
        taskCountLabel.text = "\(tasks!.count)"
        listTaskTV.reloadData()
        //router?.routeToSomewhere()
    }
}

// MARK: UITableViewController

extension ListTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasksList = tasks else { return 0 }
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectTask(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewCell

extension ListTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskList = tasks, indexPath.row < taskList.count else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTasksTVC") as! ListTasksTableViewCell
        cell.taskLabel.text = taskList[indexPath.row]
        return cell
    }
}
