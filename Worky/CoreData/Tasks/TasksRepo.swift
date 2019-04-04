//
//  TasksRepo.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

class TasksRepo: TasksDAO {
	let cdContext: NSManagedObjectContext?
	
	init(context: NSManagedObjectContext) {
		self.cdContext = context
	}

	func getContext() -> NSManagedObjectContext? {
		return cdContext
	}
	
	// get task list
	func getTaskList() -> [Task] {
		var resultTasks: [Task] = []

		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
		do {
			let results = try self.cdContext?.fetch(request)
			let  dateCreated = results as! [Task]

			for _datecreated in dateCreated {
				if _datecreated.title != nil && !(_datecreated.title?.isEmpty)! {
					resultTasks.append(_datecreated)
				}
			}
		}catch let err as NSError {
			print("Error code: \(err.code), \(err.description)")
		}
		return resultTasks
	}
	
	// get details one task
	func getTaskDetails(objectId: NSManagedObjectID) -> Task? {
		let object = cdContext?.object(with: objectId) as! Task
		return object
	}
	
	// add new task from *Task* model
	func addNewTask(task: Task) {
		do {
			let entity = NSEntityDescription.entity(forEntityName: "Task", in: cdContext!)
			
			let taskObject = NSManagedObject(entity: entity!, insertInto: cdContext)
			taskObject.setValue(task.title, forKey: "title")
			taskObject.setValue(task.descr, forKey: "descr")
			
			try cdContext!.save()
			
		} catch {
			print("error")
		}
	}
	
	func updateNewTask(task: Task) {
		do {
			let object = cdContext?.object(with: task.objectID) as! Task
			object.title = task.title
			object.descr = task.descr
			try cdContext?.save()
		} catch {
			print("Error update Task")
		}
	}
	
	// add timeInterval for task
	func addTimeInterval(objectId: NSManagedObjectID, timeInterval: TimeInterval) {
		guard let context = cdContext else { return }
		do {
			let task = context.object(with: objectId) as! Task
			
			let tracking = Tracking(context: context)
			tracking.date = Date()
			tracking.track_time = timeInterval
			
			task.addToTracking(tracking)
			
			try context.save()
		} catch {
			print("[ERROR] TasksRepo: ObjectID(\(String(describing: objectId)))")
		}
	}
	
	// detele task by *NSManagedObjectID*
	func deleteTask(objectId: NSManagedObjectID) {
		guard let context = cdContext else { return }
		
		let task = context.object(with: objectId) as! Task
		cdContext?.delete(task)
	}
}
