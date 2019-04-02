//
//  TaskDetailsViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 17/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit
import CoreData


class TaskDetailsViewController: UIViewController {

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var navBarButton: UIBarButtonItem!
	
	var cdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
	
	var taskObject: NSManagedObjectID?
	
	var didBack: (()->())?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
}
