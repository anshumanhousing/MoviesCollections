//
//  ActivityLoader.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 01/09/23.
//

import Foundation
import UIKit


class activity {
    
    class func getActivityIndicator() -> UIActivityIndicatorView {
        /*
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: 5*activityIndicator.frame.width/2, y: 9*activityIndicator.frame.height/2)
        activityIndicator.startAnimating()
        return activityIndicator
        */
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 8, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        //loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        return loadingIndicator
    }
}

