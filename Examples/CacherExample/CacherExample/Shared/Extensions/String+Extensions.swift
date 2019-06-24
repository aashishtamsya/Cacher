//
//  String+Extensions.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension String {
  var localized: String { get { return NSLocalizedString(self, comment: "") } }
}
