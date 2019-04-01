//
//  UIColor+DefineColors.swift
//  Worky
//
//  Created by Сергей Нейкович on 01/04/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit

extension UIColor {
	
	@nonobjc class var dcPrimaryColor: UIColor {
		return UIColor(red: 110.0 / 255.0, green: 242.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var dcSimpleTextColor: UIColor {
		return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var dcWarningColor: UIColor {
		return UIColor.red
	}
}
