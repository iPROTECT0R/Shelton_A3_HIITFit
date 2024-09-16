// DateExtension

// Created by Raymond Shelton on 9/8/24.

// Adds utility functions to the Date class for formatting, comparing, and manipulating dates.

import Foundation

// Extends the Date class with additional functionality
extension Date {

  // Formats the date as a string based on the provided format
  func formatted(as format: String) -> String {
    let dateFormatter = DateFormatter()  // Create a DateFormatter instance
    dateFormatter.dateFormat = format    // Set the desired date format
    return dateFormatter.string(from: self)  // Convert the date to a string using the format
  }

  // Returns the date in "yyyy MM dd" format as a string
  var yearMonthDay: String {
    let dateFormatter = DateFormatter()  // Create a DateFormatter instance
    dateFormatter.dateFormat = "yyyy MM dd"  // Set the date format
    return dateFormatter.string(from: self)  // Convert the date to a string using the format
  }

  // Checks if the current date is the same day as another date
  func isSameDay(as day: Date) -> Bool {
    return self.yearMonthDay == day.yearMonthDay  // Compare formatted strings to check if the days are the same
  }

  // Returns the name of the day of the week (e.g., "Monday")
  var dayName: String {
    let dateFormatter = DateFormatter()  // Create a DateFormatter instance
    dateFormatter.dateFormat = "EEEE"  // Set the format to day name
    return dateFormatter.string(from: self)  // Convert the date to a day name string
  }

  // Returns an array of the previous seven days including today
  var previousSevenDays: [Date] {
    (-6...0).map { day in  // Create an array of offsets from -6 to 0 (total 7 days)
      Calendar.current.date(
        byAdding: .day,  // Specify that we want to add days
        value: day,      // The number of days to add (negative values will go back in time)
        to: self) ?? Date()  // Compute the date and handle any errors by providing the current date as fallback
    }
  }
}
