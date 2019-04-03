//
//  TaskInfoViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 03/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TaskInfoViewController: UIViewController {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descrLabel: UILabel!
	@IBOutlet weak var historyTableView: UITableView!
	
	lazy var viewModel: TaskInfoViewModel = {
		var cdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
		let dbInterface = DBInterface(cdContext: cdContext!)
		return TaskInfoViewModel(dbInterface: dbInterface)
	}()
	
	var taskObject: NSManagedObjectID?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		bindUI()
	}
	
	func bindUI() {
		
		self.viewModel.taskDetailData = { [weak self] in
			let task = self?.viewModel.taskData
			self?.titleLabel.text = task?.title
			self?.descrLabel.text = task?.descr
		}
		
		self.viewModel.historyTableUpdate = { [weak self] in
			self?.historyTableView.reloadData()
		}
		
		self.viewModel.loadTaskData(objectId: taskObject)
	}
}

extension TaskInfoViewController: UITableViewDataSource {
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
extension TaskInfoViewController: UITableViewDelegate {}
