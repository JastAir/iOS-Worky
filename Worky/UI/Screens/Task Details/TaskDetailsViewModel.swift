//
//  TaskDetailsViewModel.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

class TaskDetailsViewModel {
	
	let dbInterface: DBInterface?
	init(dbInterface: DBInterface) {
		self.dbInterface = dbInterface
	}
	
	var objectId: NSManagedObjectID?
	
	var taskData: Task? {
		didSet {
			taskDetailData?()
		}
	}
	
	var historyListData: [Tracking] = [] {
		didSet {
			historyTableUpdate?()
		}
	}
	
	var showError: ((_ message: String)->())?
	var taskDetailData: (()->())?
	var historyTableUpdate: (()->())?
	var addNewTaskState: (()->())?
	var didGoBack: (()->())?
	var taskDeleted: (()->())?
	
	func loadTaskData(objectId: NSManagedObjectID?) {
		guard let taskId = objectId else {
			addNewTaskState?()
			return
		}
		
		self.objectId = taskId
		
		taskData = dbInterface?.tasksDao.getTaskDetails(objectId: taskId)
		historyListData = taskData?.tracking?.allObjects as! [Tracking]
	}
	
	func navigationBarAction(title: String?, descr: String?) {
		
		defer { didGoBack?() }
		
		if objectId == nil {
			let taskData = Task(context: (dbInterface?.tasksDao.getContext())!)
			taskData.title = title
			taskData.descr = descr
			
			dbInterface?.tasksDao.addNewTask(task: taskData)
		} else {
			guard let taskData = dbInterface?.tasksDao.getTaskDetails(objectId: objectId!) else {
				showError?("Error get task detail!")
				return
			}
			taskData.title = title
			taskData.descr = descr
			
			dbInterface?.tasksDao.updateNewTask(task: taskData)
		}
	}
	
	func deleteTask() {
		guard let id = objectId else {
			showError?("Error task ID!")
			return
		}
		dbInterface?.tasksDao.deleteTask(objectId: id)
		didGoBack?()
	}
}
