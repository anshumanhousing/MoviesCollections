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
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 8, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        return loadingIndicator
    }
}


