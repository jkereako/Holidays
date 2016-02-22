//
//  Holiday.swift
//  Holidays
//
//  Created by Jeffrey Kereakoglow on 2/22/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
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
