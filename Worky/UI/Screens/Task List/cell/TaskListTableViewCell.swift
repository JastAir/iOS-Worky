//
//  TaskListTableViewCell.swift
//  Worky
//
//  Created by Сергей Нейкович on 02/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit

protocol TaskListTableViewCellDelegate: class {
	func startButtonAction(_ timeLabel: UILabel, sender: Any)
}

class TaskListTableViewCell: UITableViewCell {
	
	var delegate: TaskListTableViewCellDelegate?
	
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var descr: UILabel!
	@IBOutlet weak var time: UILabel!
	
	@IBAction func startTrackButtonAction(_ sender: Any) {
		delegate?.startButtonAction(time, sender: sender)
	}
}
