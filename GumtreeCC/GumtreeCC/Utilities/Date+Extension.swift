//
//  Date+Extension.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation


extension Date {
    
    static func differenceInDays(fromDate: Date, toDate: Date) -> Int {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: fromDate)
        let date2 = calendar.startOfDay(for: toDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let diffInDays = components.day ?? 0

        return diffInDays
    }

    func toString(_ formatter: String = "dd MMM yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }

    static func fromString(_ dateString: String, _ formatter: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: dateString)
    }
}
