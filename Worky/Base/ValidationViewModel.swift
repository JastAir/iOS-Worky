//
//  ValidationViewModel.swift
//  Worky
//
//  Created by Сергей Нейкович on 18/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import RxSwift

protocol ValidationViewModel {
	var errorMessage: String { get }
	
	// Observables
	var data: Variable<String> { get set }
	var errorValue: Variable<String?> { get}
	
	// Validation
	func validateCredentials() -> Bool
}
