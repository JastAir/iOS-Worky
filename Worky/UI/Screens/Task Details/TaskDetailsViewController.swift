//
//  TaskDetailsViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 17/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit
import CoreData


class TaskDetailsViewController: UIViewController {
	
	@IBOutlet weak var navBarActionButton: UIBarButtonItem!
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var descriptionTextField: UITextField!
	
	@IBOutlet weak var timelineLabel: UILabel!
	@IBOutlet weak var historyTableView: UITableView!
	
	lazy var viewModel: TaskDetailsViewModel = {
		var cdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
		let dbInterface = DBInterface(cdContext: cdContext!)
		return TaskDetailsViewModel(dbInterface: dbInterface)
	}()
	
	var taskObject: NSManagedObjectID?

	var didBack: (()->())?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindUI()
    }
	
	func bindUI() {
		
		self.viewModel.addNewTaskState = { [weak self] in
			self?.title = "Add new task"
			self?.timelineLabel.isHidden = true
			self?.historyTableView.isHidden = true
		}
		
		self.viewModel.taskDetailData = { [weak self] in
			let task = self?.viewModel.taskData
			self?.titleTextField.text = task?.title
			self?.descriptionTextField.text = task?.descr
		}
		
		self.viewModel.historyTableUpdate = { [weak self] in
			self?.historyTableView.reloadData()
		}
		
		self.viewModel.didGoBack = { [weak self] in
			self?.didBack?()
			self?.navigationController?.popViewController(animated: true)
		}
		
		self.viewModel.loadTaskData(objectId: taskObject)
	}
	
	@IBAction func navigationBarButtonAction(_ sender: Any) {
		self.viewModel.navigationBarAction(
			title: titleTextField.text,
			descr: descriptionTextField.text
		)
	}
}

extension TaskDetailsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.historyListData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HistoryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryTableViewCell
//		cell.dateLabel.text = self.viewModel.historyListData[indexPath.item].date
		cell.dateLabel.text = "01.03.2019"
		cell.timeIntervalLabel.text = self.viewModel.historyListData[indexPath.item].track_time.toTimeStringFormat()
		return cell
	}
}
extension TaskDetailsViewController: UITableViewDelegate {}
