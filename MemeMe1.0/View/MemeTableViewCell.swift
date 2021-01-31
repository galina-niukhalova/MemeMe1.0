//
//  MemeTableViewCell.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 28/1/21.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet var memeImage: UIImageView!
    @IBOutlet var memeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 2, right: 4))
    }
}
