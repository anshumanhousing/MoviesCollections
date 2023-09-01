//
//  Extensions.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 26/08/23.
//

import Foundation
import UIKit

extension UIViewController{
    
    ///Present an pop up Alert 
    func showAlert(withtTitle alert: String, andMessage message: String, actionTitle  :String = "Cancel") {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
