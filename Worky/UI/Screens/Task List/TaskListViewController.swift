//
//  ViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
	
	lazy var viewModel: TaskListViewModel = {
		let dbInterface = (UIApplication.shared.delegate as! AppDelegate).dbInterface
		return TaskListViewModel(dbInterface: dbInterface)
	}()
	
	// MARK: - Outlets
	@IBOutlet var tasksTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		bindUI()
		
		viewModel.loadTasksList()
	}
	
	func bindUI(){
		tasksTableView.delegate = self
		
		viewModel.updateTasksData = { [weak self] () in
			DispatchQueue.main.async {
				self?.tasksTableView.reloadData()
			}
		}
		
		viewModel.showAlert = { [weak self] () in
			self?.showAlertWithAction(
				title: self?.viewModel.alertMessage, message: nil, action: { _ in
					self?.viewModel.alertAction()
			})
		}
		
		viewModel.showDetailsClosure = { [weak self] indexPath in
			let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TaskDetailsVC") as! TaskDetailsViewController
			vc.taskObject = self?.viewModel.tasksDataList[indexPath.item].objectID
			vc.didBack = { [weak self] in
				self?.viewModel.loadTasksList()
			}
			self?.navigationController?.pushViewController(vc, animated: true)
		}
		
		viewModel.showInfoClosure = { [weak self] indexPath, heroID in
			let cell = self?.tasksTableView.cellForRow(at: indexPath) as! TaskListTableViewCell
			self?.performSegue(withIdentifier: "task_info_segue", sender: cell)
		}
	}
	
	@objc func longPressGestureAction(longPressGestureRecognizer: UILongPressGestureRecognizer) {
		
		if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
			let touchPoint = longPressGestureRecognizer.location(in: self.view)
			if let indexPath = tasksTableView.indexPathForRow(at: touchPoint) {
				
				self.vibrate(.heavy)
				self.viewModel.showDetailsClosure?(indexPath)
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.destination is TaskInfoViewController {
			guard let cell = sender as? TaskListTableViewCell else { return }
			
			let vc = segue.destination as! TaskInfoViewController
			vc.taskObject = cell.taskID
			vc.viewHeroID = cell.contentView.hero.id
		}
		
		if segue.destination is TaskDetailsViewController {
			let vc = segue.destination as! TaskDetailsViewController
			vc.didBack = { [weak self] in
				self?.viewModel.loadTasksList()
			}
		}
		
		
		self.vibrate(.light)
	}
	
	func updateTable() {
		viewModel.loadTasksList()
	}
}

extension TaskListViewController: UITableViewDataSource {


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TaskListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "taskListCell") as? TaskListTableViewCell
	
		cell.contentView.hero.isEnabled = true
		cell.contentView.hero.id = "hero-id-cell-\(indexPath.item)"
		cell.contentView.hero.modifiers = [.translate(y:100)]
		
		cell.taskID = self.viewModel.tasksDataList[indexPath.item].objectID
		
		cell.title.text = self.viewModel.tasksDataList[indexPath.item].title
		cell.descr.text = self.viewModel.tasksDataList[indexPath.item].descr
		cell.time.text = "00:00:00"
		
		cell.stopTimer = { [weak self] taskID, timeInterval in
			self?.viewModel.stopTimerForTask(taskID, with: timeInterval)
		}
		
		let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
		cell.addGestureRecognizer(longPressRecognizer)
		
		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.tasksDataList.count
	}


	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.viewModel.tableSelectRow(indexPath: indexPath, heroID: "hero-id-cell-\(indexPath.item)")
	}
}

extension TaskListViewController: UITableViewDelegate {}
