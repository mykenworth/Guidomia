//
//  UITableViewCell+Extension.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import Foundation
import UIKit

extension UITableViewCell {
  func hideSeparator() {
    self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
  }

  func showSeparator() {
    self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
  }
}
