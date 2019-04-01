//
//  TaskListViewModel.swift
//  Worky
//
//  Created by Сергей Нейкович on 18/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

class TaskListViewModel: BaseViewModel {
	
	// viewControllerActions
	var isLoading: Bool = false {
		didSet{
			self.updateLoadingStatus?()
		}
	}
	
	var alertMessage: String? {
		didSet {
			self.showAlert?()
		}
	}
	
	var tasksDataList: [Task] = [] {
		didSet {
			self.updateTasksData?()
		}
	}
	
	var showAlert: (() -> ())?
	var updateLoadingStatus: (()->())?
	var updateTasksData: (()->())?
	var showDetailsClosure: ((_ indexPath: IndexPath)->())?
	var updateCellTimeLabel: ((_ timeInterval: TimeInterval) -> ())?
	
	// vars
	var timerValue: TimeInterval = 0.0 {
		didSet{
			updateCellTimeLabel?(timerValue)
		}
	}
	var timer: Timer?
	
	
	// coreData
//	let cdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

	func loadTasksList(){
//		var resultTasks: [Task] = []
//
//		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//		do {
//			let results = try cdContext?.fetch(request)
//			let  dateCreated = results as! [Task]
//
//			for _datecreated in dateCreated {
//				if _datecreated.title != nil && !(_datecreated.title?.isEmpty)! {
//					resultTasks.append(_datecreated)
//				}
//			}
//		}catch let err as NSError {
//			onError(message: err.domain)
//		}
		
//		taskListCellData.onNext(resultTasks)
	}
	
	func tableSelectRow(indexPath: IndexPath){
		showDetailsClosure?(indexPath)
	}
	
	
	
	func alertAction(){
		// TODO: setup alert action
	}
	
	func onError(message: String) {
		print("taskListViewModel: \(message)")
	}
}
