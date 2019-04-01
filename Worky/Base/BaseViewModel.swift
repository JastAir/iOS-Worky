//
//  BaseViewModel.swift
//  Worky
//
//  Created by Сергей Нейкович on 18/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModel {
	
	func onError(message: String)
}
