//
//  BaseDAO.swift
//  Worky
//
//  Created by Сергей Нейкович on 03/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import CoreData

protocol BaseDAO {
	func getContext() -> NSManagedObjectContext?
}
