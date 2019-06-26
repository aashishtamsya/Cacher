//
//  DateFormatter+Extensions.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 26/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

/// Cached map for different formatters.
private var formatterMap: [String: DateFormatter] = [:]

/// Traditional date formate used by the API.
let apiDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

extension DateFormatter {
  class func cachedFormatterWithFormat(format: String, withLocale locale: Locale? = nil, withTimeZone timeZone: TimeZone? = nil) -> DateFormatter {
    if let formatter = formatterMap[format] {
      if let localeToSet = locale {
        formatter.locale = localeToSet
      }
      if let timeZoneToSet = timeZone {
        formatter.timeZone = timeZoneToSet
      }
      return formatter
    } else {
      let newDateFormatter = DateFormatter()
      newDateFormatter.dateFormat = format
      if let localeToSet = locale {
        newDateFormatter.locale = localeToSet
      }
      if let timeZoneToSet = timeZone {
        newDateFormatter.timeZone = timeZoneToSet
      }
      formatterMap.updateValue(newDateFormatter, forKey: format)
      return newDateFormatter
    }
  }
  
  class func clearCache() {
    formatterMap.removeAll()
  }
}
