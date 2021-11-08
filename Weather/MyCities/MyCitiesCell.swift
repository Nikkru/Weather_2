//
//  MyCitiesCell.swift
//  Weather
//
//  Created by Nikolai Krusser on 06.11.2021.
//

import UIKit

class MyCitiesCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
