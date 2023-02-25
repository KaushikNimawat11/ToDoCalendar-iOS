//
//  ViewController.swift
//  ToDoCalendar
//
//  Created by mac on 23/02/23.
//

import UIKit

var datesDict = [String:String]()
var tasks = [Task]()

struct Task {
    var date: String
    var taskName: String
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var hideOrViewLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var hideCalendarView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var selectedDate = Date()
    var totalSquare = [String]()
    var isCalendarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCells()
        setMonth()
        myCollectionView.reloadData()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeCalendar(_:)))
        hideCalendarView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
        myCollectionView.reloadData()
    }
    
    @objc func closeCalendar(_ sender: UITapGestureRecognizer? = nil) {
        if isCalendarHidden == true {
            self.collectionViewHeight.constant = 260
            self.hideOrViewLabel.text = "Hide Calendar"
            self.isCalendarHidden = false
        }
        else {
            self.collectionViewHeight.constant = 0
            self.hideOrViewLabel.text = "View Calendar"
            self.isCalendarHidden = true
        }
    }
    
    func setCells() {
        let cellWidth = (myCollectionView.frame.size.width - 2) / 8
        let cellHeight = (myCollectionView.frame.size.height - 20) / 6
        let flowLayout = myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func setMonth() {
        totalSquare.removeAll()
        let daysInMonth = CalendarMethods().numberOfDays(date: selectedDate)
        let firstOfMonth = CalendarMethods().firstOfMonth(date: selectedDate)
        let startingBlanks = CalendarMethods().weekDay(date: firstOfMonth)
        
        var count = 1
        while(count<=42){
            
            if(count<=startingBlanks || count - startingBlanks > daysInMonth){
                totalSquare.append("")
            }
            else{
                totalSquare.append(String(count - startingBlanks))
            }
            count += 1
        }
        monthLabel.text = CalendarMethods().getMonthName(date: selectedDate) + " " + CalendarMethods().getYear(date: selectedDate)
        myCollectionView.reloadData()
    }

    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarMethods().plusMonth(date: selectedDate)
        setMonth()
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarMethods().minusMonth(date: selectedDate)
        setMonth()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquare.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquare[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDateString = CalendarMethods().getYear(date: selectedDate) + "-" + CalendarMethods().getMonthNumber(date: selectedDate) + "-" + totalSquare[indexPath.item]
        
        if datesDict[selectedDateString] == nil && totalSquare[indexPath.row] != "" {
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "AddTaskVC") as! AddTaskViewController
            secondViewController.thisDate = selectedDateString
            self.navigationController!.pushViewController(secondViewController, animated: true)
            
        }
        else {
            let title = (totalSquare[indexPath.row] != "") ? "Task Already Assigned" : "Date Invalid"
            let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! AddTaskCell
        cell1.taskLabel.text = tasks[indexPath.row].taskName
        cell1.taskDate.text = tasks[indexPath.row].date
        cell1.index = indexPath.row
        cell = cell1
        return cell

    }
    
    
}

