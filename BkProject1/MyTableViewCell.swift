//
//  MyTableViewCell.swift
//  BkProject1
//
//  Created by Emil on 31.07.2022.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - for set a object to cell (count of array)
    func set (objectiv: Emodji) {
        self.emojiLabel.text = objectiv.emoji
        self.nameLabel.text = objectiv.name
        self.descriptionLabel.text = objectiv.description
    }
}
