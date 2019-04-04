//
//  NSDate+DateFormater.swift
//  Worky
//
//  Created by Сергей Нейкович on 04/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation

enum DateFormattedType {
	case full
	case date
	case time
}

extension Date {
	
	func toStringFormat(type: DateFormattedType) -> String {
		let dateFormatterGet = DateFormatter()
		
		switch type {
		case .full:
			dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
			
		case .date:
			dateFormatterGet.dateFormat = "yyyy-MM-dd"
			
		case .time:
			dateFormatterGet.dateFormat = "HH:mm:ss"
		}
		
		return dateFormatterGet.string(from: self)
	}
	
}
