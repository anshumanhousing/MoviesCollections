//
//  UITableView.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 29/08/23.
//

import Foundation
import UIKit


extension UITableView {
    
  /// For Cell Reuse 
    func dequeueReuseCell<cell: UITableViewCell>(withIdentifiers identifier: String ,forIndexPath indexPath: IndexPath) -> cell {
      return dequeueReusableCell(withIdentifier: identifier,
      for: indexPath) as! cell
  }
}


extension String{
    func correctUrl() -> Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}
