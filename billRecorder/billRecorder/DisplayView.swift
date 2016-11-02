//
//  BillView.swift
//  billRecorder
//
//  Created by 吴昊 on 21/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit

class DisplayView: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
