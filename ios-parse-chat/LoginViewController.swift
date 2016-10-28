//
//  LoginViewController.swift
//  ios-parse-chat
//
//  Created by Savio Tsui on 10/27/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    fileprivate var user: PFUser!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSuccessSegue" {
            if let destinationVC = segue.destination as? ChatViewController {
                destinationVC.user = user
            }
        }
    }

    @IBAction func Login(_ sender: UIButton) {
        let username = usernameField.text
        let password = passwordField.text

        do {
            try user = PFUser.logIn(withUsername: username!, password: password!)
        }
        catch {
            ViewControllerHelper.displayOKAlert(viewController: self, message: "failed to login with username '" + username! + "'")
            return
        }
    }

    @IBAction func Signup(_ sender: UIButton) {
        user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        // user.email = "email@example.com"

        if (user.password == "") {
            ViewControllerHelper.displayOKAlert(viewController: self, message: "No password")
            return
        }

        user.signUpInBackground {(succeeded, error) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                ViewControllerHelper.displayOKAlert(viewController: self, message: errorString)
            } else {
                // Hooray! Let them use the app now.
                self.performSegue(withIdentifier: "LoginSuccessSegue", sender: nil)
            }
        }
    }
}
