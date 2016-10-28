//
//  ChatViewController.swift
//  ios-parse-chat
//
//  Created by Savio Tsui on 10/27/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    var user: PFUser!

    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var sendMessageText: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messageTable: UITableView!

    fileprivate var messageData: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        messageTable.dataSource = self
        messageTable.estimatedRowHeight = 100
        messageTable.rowHeight = UITableViewAutomaticDimension

        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)

        onTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground()

        dismiss(animated: true, completion: nil)
    }

    @IBAction func sendMessage(_ sender: UIButton) {
        let message = PFObject(className:"Message")
        message["text"] = sendMessageText.text
        message["user"] = PFUser.current()
        message["updatedAt"] = NSDate()

        message.saveInBackground {
            (succeeded, error) -> Void in
            if (succeeded) {
                // The object has been saved.
                NSLog("MESSAGE SAVED: " + (message["user"] as! PFUser).username! + " - " + (message["text"] as! String))
            } else {
                // There was a problem, check error.description
                ViewControllerHelper.displayOKAlert(viewController: self, message: (error?.localizedDescription)!)
            }
        }
    }

    func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className:"Message")
        query.includeKey("user")
        query.includeKey("updatedAt")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground {
            (objects, error) -> Void in

            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    self.messageData = objects
                    self.messageTable.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITableViewDelegate {
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        let messageObject = self.messageData[indexPath.row] as PFObject
        let messageSender = messageObject["user"] == nil ? "" : (messageObject["user"] as! PFUser).username
        let messageText = messageObject["text"] == nil ? "" : messageObject["text"] as! String
        cell.messageText.text = messageSender! + ": " + messageText

        return cell
    }
}
