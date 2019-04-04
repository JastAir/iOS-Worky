//
//  TaskInfoViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 03/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import UIKit
import Hero
import CoreData

class TaskInfoViewController: UIViewController {
	
	var panGR: UIPanGestureRecognizer!
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descrLabel: UILabel!
	@IBOutlet weak var historyTableView: UITableView!
	
	var taskObject: NSManagedObjectID?
	var viewHeroID: String? {
		didSet {
			self.view.hero.isEnabled = true
			self.view.hero.id = viewHeroID
			self.view.hero.modifiers = [.translate(y:100)]
		}
	}
	
	lazy var viewModel: TaskInfoViewModel = {
		var cdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
		let dbInterface = DBInterface(cdContext: cdContext!)
		return TaskInfoViewModel(dbInterface: dbInterface)
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		panGR = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
		view.addGestureRecognizer(panGR)
		
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryTableViewCell
		
		let date = self.viewModel.historyListData[indexPath.item].date
		
		cell?.dateLabel.text = date!.toStringFormat(type: .date)
		cell?.timeIntervalLabel.text = self.viewModel.historyListData[indexPath.item].track_time.toTimeStringFormat()
		
		return cell!
	}
}
extension TaskInfoViewController: UITableViewDelegate {}

extension TaskInfoViewController {
	@objc func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
		switch panGR.state {
		
		case .began:
			dismiss(animated: true, completion: nil)
			
		case .changed:
			let translation = panGR.translation(in: nil)
			let progress = translation.y / 2 / view.bounds.height
			Hero.shared.update(progress)
			
		default:
			Hero.shared.finish()
		}
	}
}
