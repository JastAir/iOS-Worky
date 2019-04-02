//
//  TaskListTableViewCell.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewCell: UITableViewCell {
	
	var taskID: NSManagedObjectID?
	
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var descr: UILabel!
	@IBOutlet weak var time: UILabel!
	
	
	var stopTimer: ((_ taskID: NSManagedObjectID, _ timeInterval: TimeInterval)->())?
	
	var timerValue: TimeInterval = 0.0
	var timer: Timer?
	
	@IBAction func startTrackButtonAction(_ sender: Any) {
		let selfButton = sender as! UIButton

		if timer == nil {
			timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: {
				self.timerValue += $0.timeInterval
				self.time.text = self.timerValue.toTimeStringFormat()
			})
			timer?.fire()

			selfButton.setImage(UIImage(named: "ic_stop_btn"), for: .normal)
			selfButton.setTitleColor(.dcWarningColor, for: .normal)
		} else {
			stopTimer?(taskID!, timerValue)
			
			timer?.invalidate()
			timer = nil
			
			timerValue = 0.0
			time.text = timerValue.toTimeStringFormat()

			selfButton.setImage(UIImage(named: "ic_start_btn"), for: .normal)
			selfButton.setTitleColor(.dcPrimaryColor, for: .normal)
			
		}
	}
}
