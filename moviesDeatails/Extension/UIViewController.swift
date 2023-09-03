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
    
    func alertLoader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = activity.getActivityIndicator()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
        
    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }

}
