//
//  AddTaskViewController.swift
//  ToDoCalendar
//
//  Created by mac on 24/02/23.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var taskField: UITextField!
    var thisDate: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateField.text = thisDate
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if taskField.text != "" {
            datesDict[thisDate] = taskField.text
            let newTask = Task(date: thisDate, taskName: taskField.text ?? "")
            tasks.append(newTask)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
