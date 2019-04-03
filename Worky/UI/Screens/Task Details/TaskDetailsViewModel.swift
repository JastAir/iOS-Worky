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
	
	var taskDetailData: (()->())?
	var historyTableUpdate: (()->())?
	var addNewTaskState: (()->())?
	
	func loadTaskData(objectId: NSManagedObjectID?) {
		print("[VM] taskData with objectID: \(String(describing: objectId))")
		guard let taskId = objectId else {
			addNewTaskState?()
			return
		}
		
		taskData = dbInterface?.tasksDao.getTaskDetails(objectId: taskId)
		historyListData = taskData?.tracking?.allObjects as! [Tracking]
	}
}
