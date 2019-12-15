//
//  ViewController.swift
//  MAPD714_FinalTest
//
//  Created by Pratiksha Kathiriya on 2019-12-11.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Bmi: UILabel!
    @IBOutlet weak var Weight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
