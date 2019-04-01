//
//  ViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, TaskDetailsViewControllerDelegate {
	
	lazy var viewModel: TaskListViewModel = {
		return TaskListViewModel()
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
			vc.delegate = self
			self?.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is TaskDetailsViewController {
			let vc = segue.destination as! TaskDetailsViewController
			vc.delegate = self
		}
	}
	
	func updateTable() {
		viewModel.loadTasksList()
	}
}

extension TaskListViewController: UITableViewDataSource, TaskListTableViewCellDelegate {


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TaskListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "taskListCell") as? TaskListTableViewCell
		cell.title.text = self.viewModel.tasksDataList[indexPath.item].title
		cell.descr.text = self.viewModel.tasksDataList[indexPath.item].descr
		cell.time.text = "00:00:00"
		
		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.tasksDataList.count
	}


	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.viewModel.tableSelectRow(indexPath: indexPath)
	}
	
	func startButtonAction(_ timeLabel: UILabel, sender: Any) {
		let selfButton = sender as! UIButton
		
		if timer == nil {
			timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: {
				self.timerValue += $0.timeInterval
				timeLabel.text = self.timerValue.toTimeStringFormat()
			})
			timer?.fire()
			
			selfButton.setImage(UIImage(named: "ic_stop_btn"), for: .normal)
			selfButton.setTitleColor(.dcWarningColor, for: .normal)
		} else {
			timer?.invalidate()
			timer = nil
			
			selfButton.setImage(UIImage(named: "ic_start_btn"), for: .normal)
			selfButton.setTitleColor(.dcPrimaryColor, for: .normal)
			
//			showAlertWithAction(
//				title: "Save timer result for task: \"\(title.text ?? "UNKNOWN")\"?",
//				message: "Timer data: \(timerValue.toTimeStringFormat())",
//				action: {_ in}
//			)
		}
	}
}

extension TaskListViewController: UITableViewDelegate {}
