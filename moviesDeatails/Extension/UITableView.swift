//
//  UITableView.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 29/08/23.
//

import Foundation
import UIKit


extension UITableView {
  func dequeueReuseCell<cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> cell {
      return dequeueReusableCell(withIdentifier: Identifiers.CELL_IDENTIFIER,
      for: indexPath) as! cell
  }
}

