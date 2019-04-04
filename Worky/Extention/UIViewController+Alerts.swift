//
//  UIViewController+Alerts.swift
//  Worky
//
//  Created by Сергей Нейкович on 01/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	
	func showAlertWithAction(title: String?, message: String?, action: @escaping (UIAlertAction?) -> Void){
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: action))
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		self.present(alertController, animated: true, completion: nil)
	}
	
	func showSimpleAlert(title: String?){
		let alertController = UIAlertController(title: title, message: nil,preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		self.present(alertController, animated: true, completion: nil)
	}
	
}
