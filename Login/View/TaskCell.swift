//
//  TaskCell.swift
//  ToDO
//
//  Created by Nikita Paralkar on 2019-12-07.
//  Copyright © 2019 Nikita Paralkar. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet var checkBoxOutlet : UIButton!
    @IBOutlet var taskNameLabel : UILabel!
    @IBAction func checkBoxAction(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
