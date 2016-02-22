//
//  DateTests.swift
//  Holidays
//
//  Created by Jeff Kereakoglow on 10/1/15.
//  Copyright © 2015 Alexis Digital. All rights reserved.
//

import XCTest
@testable import Holidays

class DateTests: XCTestCase {
  var date: Date!

  override func setUp() {
    super.setUp()
    date = MockDate()
  }

  override func tearDown() {
    date = nil
  }

  func testBeginningOfDay() {
    let comps0 = NSDateComponents()
    comps0.year = 2015
    comps0.month = 9
    comps0.day = 30

    let aDate = date.beginningOfDay(
      date:NSCalendar.currentCalendar().dateFromComponents(comps0)!
    )

    let comps1 = components(date: aDate)

    XCTAssertTrue(comps1.year == 2015)
    XCTAssertTrue(comps1.month == 9)
    XCTAssertTrue(comps1.day == 30)
    XCTAssertTrue(comps1.hour == 0)
    XCTAssertTrue(comps1.minute == 0)
    XCTAssertTrue(comps1.second == 0)
  }

  func testEndOfDay() {
    let comps0 = NSDateComponents()
    comps0.year = 2015
    comps0.month = 9
    comps0.day = 30

    let aDate = date.endOfDay(
      date:NSCalendar.currentCalendar().dateFromComponents(comps0)!
    )

    let comps1 = components(date: aDate)

    XCTAssertTrue(comps1.year == 2015)
    XCTAssertTrue(comps1.month == 9)
    XCTAssertTrue(comps1.day == 30)
    XCTAssertTrue(comps1.hour == 23)
    XCTAssertTrue(comps1.minute == 59)
    XCTAssertTrue(comps1.second == 59)
  }

  func testNewYears() {
    let holiday = date.newYears

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 1)
    XCTAssertTrue(comps.day == 1)
  }

  func testMartinLutherKingJrDay() {
    let holiday = date.martinLutherKingJr

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 1)
    XCTAssertTrue(comps.day == 19)
  }

  func testValentines() {
    let holiday = date.valentines

    XCTAssertTrue(holiday.federalHoliday == false)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 2)
    XCTAssertTrue(comps.day == 14)
  }

  func testValentinesAdjustment() {
    let holiday = date.valentines

    XCTAssertTrue(holiday.federalHoliday == false)

    let adjustedHoliday =  date.adjustForBusiness(holiday: holiday)

    XCTAssertTrue(adjustedHoliday.federalHoliday == false)

    let comps = components(date: adjustedHoliday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 2)
    XCTAssertTrue(comps.day == 13)
  }

  func testSaintPatricks() {
    let holiday = date.saintPatricks

    XCTAssertTrue(holiday.federalHoliday == false)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 3)
    XCTAssertTrue(comps.day == 17)
  }

  func testWashingtonsBirthdayDay() {
    let holiday = date.washingtonsBirthday

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 2)
    XCTAssertTrue(comps.day == 16)
  }

  func testMemorialDay() {
    let holiday = date.memorial

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 5)
    XCTAssertTrue(comps.day == 25)
  }

  func testIndependenceDay() {
    let holiday = date.independence

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 7)
    XCTAssertTrue(comps.day == 4)
  }

  // Independence Day in 2015 was on a Saturday, so it was moved to a Friday.
  func testIndependenceDayAdjustment() {
    let holiday = date.independence

    XCTAssertTrue(holiday.federalHoliday == true)

    let adjustedHoliday =  date.adjustForBusiness(holiday: holiday)

    XCTAssertTrue(adjustedHoliday.federalHoliday == true)

    let comps = components(date: adjustedHoliday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 7)
    XCTAssertTrue(comps.day == 3)
  }

  func testLaborDay() {
    let holiday = date.labor

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 9)
    XCTAssertTrue(comps.day == 7)
  }

  func testColumbusDay() {
    let holiday = date.columbus

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 10)
    XCTAssertTrue(comps.day == 12)

  }

  // Columbus Day is always on a Monday, so we expect no change
  func testColumbusDayAdjustment() {
    let holiday = date.columbus

    XCTAssertTrue(holiday.federalHoliday == true)

    let adjustedHoliday =  date.adjustForBusiness(holiday: holiday)

    XCTAssertTrue(adjustedHoliday.federalHoliday == true)

    let comps = components(date: adjustedHoliday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 10)
    XCTAssertTrue(comps.day == 12)
  }

  func testHalloween() {
    let holiday = date.halloween

    XCTAssertTrue(holiday.federalHoliday == false)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 10)
    XCTAssertTrue(comps.day == 31)
  }

  func testHalloweenAdjustment() {
    let holiday = date.halloween

    XCTAssertTrue(holiday.federalHoliday == false)

    let adjustedHoliday =  date.adjustForBusiness(holiday: holiday)

    XCTAssertTrue(adjustedHoliday.federalHoliday == false)

    let comps = components(date: adjustedHoliday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 10)
    XCTAssertTrue(comps.day == 30)
  }

  func testVeteransDay() {
    let holiday = date.veterans

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 11)
    XCTAssertTrue(comps.day == 11)
  }

  func testThanksgivingDay() {
    let holiday = date.thanksgiving

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 11)
    XCTAssertTrue(comps.day == 26)
  }

  func testChristmas() {
    let holiday = date.christmas

    XCTAssertTrue(holiday.federalHoliday == true)

    let comps = components(date: holiday.date)

    XCTAssertTrue(comps.year == 2015)
    XCTAssertTrue(comps.month == 12)
    XCTAssertTrue(comps.day == 25)
  }
  
  private func components(date date: NSDate) -> NSDateComponents  {
    return NSCalendar.currentCalendar().components(
      [.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date
    )
  }  
}
