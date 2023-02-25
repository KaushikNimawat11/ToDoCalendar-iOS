//
//  AddTaskCell.swift
//  ToDoCalendar
//
//  Created by mac on 24/02/23.
//

import UIKit

class AddTaskCell: UITableViewCell {
    
    var index: Int!

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteTask(_ sender: Any) {
        if let date = taskDate.text {
            datesDict.removeValue(forKey: date)
        }
        tasks.remove(at: index)
    }
}
