//
//  UIViewController+Vibration.swift
//  Worky
//
//  Created by Сергей Нейкович on 03/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
	func vibrate(_ type: UIImpactFeedbackGenerator.FeedbackStyle) {
		let vibrationHandler = UIImpactFeedbackGenerator(style: type)
		vibrationHandler.impactOccurred()
	}
}
