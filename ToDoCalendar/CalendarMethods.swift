//
//  CalendarMethods.swift
//  ToDoCalendar
//
//  Created by mac on 24/02/23.
//

import Foundation
import UIKit

class CalendarMethods {
    
    let myCalendar = Calendar.current
    
    func plusMonth(date: Date) -> Date{
        return myCalendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date{
        return myCalendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func getMonthName(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func getMonthNumber(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date)
    }
    
    func getYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }
    
    func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func numberOfDays(date: Date) -> Int{
        let range = myCalendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func firstOfMonth(date: Date) -> Date{
        let component = myCalendar.dateComponents([.year, .month], from: date)
        return myCalendar.date(from: component)!
    }
    
    func weekDay(date: Date) -> Int{
        let component = myCalendar.dateComponents([.weekday], from: date)
        return component.weekday! - 1
    }
}
