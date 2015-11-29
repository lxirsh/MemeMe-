//
//  MemeTableViewCell.swift
//  MemeMe 1.0
//
//  Created by Lance Hirsch on 11/29/15.
//  Copyright © 2015 Lance Hirsch. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
