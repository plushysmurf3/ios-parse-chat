//
//  ViewControllerHelper.swift
//  ios-parse-chat
//
//  Created by Savio Tsui on 10/27/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ViewControllerHelper {
    static func displayOKAlert(viewController: UIViewController, message: String) {
        // Show the errorString somewhere and let the user try again.
        let alertController = UIAlertController(title: "Title", message: message, preferredStyle: .alert)

        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
