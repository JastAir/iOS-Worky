//
//  TasksDAO.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

protocol TasksDAO {
	
	func getTaskList() -> [Task]
	func getTaskDetails(objectId: NSManagedObjectID) -> Task?
	func addNewTask(task: Task)
	func deleteTask(objectId: NSManagedObjectID)
	func addTimeInterval(objectId: NSManagedObjectID, timeInterval: TimeInterval)
	
}
