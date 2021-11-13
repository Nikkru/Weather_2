//
//  MyGroupsCell.swift
//  Weather
//
//  Created by Nikolai Krusser on 13.11.2021.
//

import UIKit

class MyGroupsCell: UITableViewCell {

    @IBOutlet weak var myGroupLabel: UILabel!
    @IBOutlet weak var myGroupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
