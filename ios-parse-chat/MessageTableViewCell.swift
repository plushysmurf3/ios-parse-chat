//
//  MessageTableViewCell.swift
//  ios-parse-chat
//
//  Created by Savio Tsui on 10/27/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
