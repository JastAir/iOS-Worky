//
//  TimeInterval+TimeFormat.swift
//  Worky
//
//  Created by Сергей Нейкович on 19/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation

extension TimeInterval{
	
	func toTimeStringFormat() -> String {
		
		let time = NSInteger(self)
		
		let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
		let seconds = time % 60
		let minutes = (time / 60) % 60
		let hours = (time / 3600)
		
		return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
		
	}
}
