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
	
	let dbInterface: DBInterface?
	init(dbInterface: DBInterface) {
		self.dbInterface = dbInterface
	}
	
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
	
	
	func loadTasksList() {
		tasksDataList = dbInterface?.tasksDao.getTaskList() ?? []
	}
	
	func tableSelectRow(indexPath: IndexPath){
		showDetailsClosure?(indexPath)
	}
	
	func stopTimerForTask(_ taskID: NSManagedObjectID, with timeInterval: TimeInterval){
		dbInterface?.tasksDao.addTimeInterval(objectId: taskID, timeInterval: timeInterval)
	}
	
	func alertAction(){
		// TODO: setup alert action
	}
	
	func onError(message: String) {
		print("taskListViewModel: \(message)")
	}
}
