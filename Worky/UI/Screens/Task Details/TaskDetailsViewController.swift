//
//  TaskDetailsViewController.swift
//  Worky
//
//  Created by Сергей Нейкович on 17/03/2019.
//  Copyright © 2019 F Developers. All rights reserved.
//

import UIKit
import CoreData

protocol TaskDetailsViewControllerDelegate: class {
	func updateTable()
}

enum TaskDetailsState {
	case EDIT
	case INFO
	case ADD
}

class TaskDetailsViewController: UIViewController {

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var navBarButton: UIBarButtonItem!
	
	var cdContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
	
	var taskObject: NSManagedObjectID?
	var delegate: TaskDetailsViewControllerDelegate?
	
	var state: TaskDetailsState = .ADD
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if taskObject == nil {
			
			navBarButton.title = "Save"
			self.title = "Add new task"
			
			state = .ADD
		} else {
			
			navBarButton.title = "Edit"
			self.title = "Info task"
			
			state = .INFO
			
			titleTextField.isEnabled = false
			descriptionTextField.isEnabled = false
			
			if let taskData = cdContext?.object(with: taskObject!) as? Task {
				
				titleTextField.text = taskData.title
				descriptionTextField.text = taskData.descr
			}
		}
		self.navigationItem.rightBarButtonItem = navBarButton
    }

	@IBAction
	func appBarButtonAction(_ sender: Any) {
		
		guard let delegate = delegate else { return }
		
		switch state {
			case .ADD:
				do {
					let entity = NSEntityDescription.entity(forEntityName: "Task", in: cdContext!)
					
					let task = NSManagedObject(entity: entity!, insertInto: cdContext)
					task.setValue(titleTextField.text, forKey: "title")
					task.setValue(descriptionTextField.text, forKey: "descr")
					
					try cdContext!.save()
					
				} catch {
					print("error")
				}
				
				delegate.updateTable()
				navigationController?.popViewController(animated: true)
			case .EDIT:
				
				state = .INFO
				self.title = "Info task"
				navBarButton.title = "Edit"
				
				print("update")
			
			case .INFO:
				
				state = .EDIT
				self.title = "Edit task"
				navBarButton.title = "Delete"
				
				titleTextField.isEnabled = true
				descriptionTextField.isEnabled = true
				
				print("info")
		}
	}
}
