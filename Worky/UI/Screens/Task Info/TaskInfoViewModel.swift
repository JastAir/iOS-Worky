//
//  TaskInfoViewModel.swift
//  Worky
//
//  Created by Сергей Нейкович on 03/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

class TaskInfoViewModel {
	
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
	
	func loadTaskData(objectId: NSManagedObjectID?) {
		guard let taskId = objectId else { return }
		
		taskData = dbInterface?.tasksDao.getTaskDetails(objectId: taskId)
		historyListData = taskData?.tracking?.allObjects as! [Tracking]
	}
}
