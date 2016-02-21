//
//  Date.swift
//  Holidays
//
//  Created by Jeff Kereakoglow on 10/1/15.
//  Copyright © 2015 Alexis Digital. All rights reserved.
//

import Foundation

struct Holiday {
  let federalHoliday: Bool
  let date: NSDate

  init(federalHoliday fh: Bool, date d: NSDate) {
    federalHoliday = fh
    date = d
  }
}

class Date {
  var currentYear: Int {
    return NSCalendar.currentCalendar().component(.Year, fromDate: NSDate())
  }

  var newYears: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 1
    components.day = 1

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  // Third Monday of January
  var martinLutherKingJr: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 1
    components.weekdayOrdinal = 3 // "Third"
    components.weekday = 2 // "Monday"

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  // Third Monday of February
  var washingtonsBirthday: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 2
    components.weekdayOrdinal = 3
    components.weekday = 2

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  var valentines: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 2
    components.day = 14

    let holiday = Holiday(
      federalHoliday: false, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  var saintPatricks: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 3
    components.day = 17

    let holiday = Holiday(
      federalHoliday: false, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  // Last Monday of May
  var memorial: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 5

    let date = dateOfFinalWeekDay(
      weekDay: 2, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return Holiday(federalHoliday: true, date: date)
  }

  var independence: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 7
    components.day = 4

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  // First Monday of September
  var labor: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 9
    components.weekdayOrdinal = 1
    components.weekday = 2

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  // Second Monday of October
  var columbus: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 10
    components.weekdayOrdinal = 2
    components.weekday = 2

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  var halloween: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 10
    components.day = 31

    let holiday = Holiday(
      federalHoliday: false, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  var veterans: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 11
    components.day = 11

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  // Fourth Thursday of November
  var thanksgiving: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 11
    components.weekdayOrdinal = 4
    components.weekday = 5

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  var christmas: Holiday {
    let components = NSDateComponents()
    components.year = currentYear
    components.month = 12
    components.day = 25

    let holiday = Holiday(
      federalHoliday: true, date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

    return holiday
  }

  func beginningOfDay(date date: NSDate) -> NSDate {
    let components = NSCalendar.currentCalendar().components(
      [.Year, .Month, .Day], fromDate: date
    )

    // Find the beginning of today
    guard let date =  NSCalendar.currentCalendar().dateFromComponents(components) else {
      fatalError("Unable to find date.")
    }

    return date
  }

  func endOfDay(date date: NSDate) -> NSDate {
    let components = NSDateComponents()
    components.day = 1

    guard let aDate = NSCalendar.currentCalendar().dateByAddingComponents(
      components,
      toDate: date,
      options: []
      ) else {
        fatalError("Unable to find date.")
    }

    return aDate.dateByAddingTimeInterval(-1)

  }

  func adjustForBusiness(holiday holiday: Holiday) -> Holiday {
    let components = NSCalendar.currentCalendar().components(
      [.Year, .Month, .Weekday, .Day], fromDate: holiday.date
    )

    switch components.weekday {

      // Sunday
    case 1:
      // If this holiday is a federal holiday, then the user likely has the day off
      if holiday.federalHoliday {
        components.day++
      }

        // Otherwise, it's a fun day (i.e. Halloween), so, celebreate it on a Friday
      else {
        components.day -= 2
      }

      // Saturday
    case 7:
      components.day--

    default: break
    }

    return Holiday(
      federalHoliday: holiday.federalHoliday,
      date: NSCalendar.currentCalendar().dateFromComponents(components)!
    )

  }

  private func finalDayOfMonth(date date: NSDate) -> NSDate {
    let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day],
      fromDate: date
    )

    components.month++
    components.day = 0

    return NSCalendar.currentCalendar().dateFromComponents(components)!
  }

  private func dateOfFinalWeekDay(weekDay weekDay: Int, date: NSDate) -> NSDate {

    let components = NSCalendar.currentCalendar().components(
      [.Year, .Month, .Day, .Weekday], fromDate: finalDayOfMonth(date: date)
    )

    if components.weekday >= weekDay {
      components.day -= components.weekday - weekDay
    }
    else {
      components.day += weekDay - components.weekday - 7
    }
    
    return NSCalendar.currentCalendar().dateFromComponents(components)!
  }
}
