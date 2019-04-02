//
//  DBInterface.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

class DBInterface {
	
	let tasksDao: TasksDAO
	
	init(cdContext: NSManagedObjectContext) {
		tasksDao = TasksRepo(context: cdContext)
	}
}
