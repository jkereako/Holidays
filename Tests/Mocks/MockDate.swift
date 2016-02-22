//
//  MockDate.swift
//  Holidays
//
//  Created by Jeffrey Kereakoglow on 2/22/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation
@testable import Holidays

class MockDate: Date {
  override var currentYear: Int {
    return 2015
  }
}