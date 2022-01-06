//
//  MyCitiesCell.swift
//  Weather
//
//  Created by Nikolai Krusser on 06.11.2021.
//

import UIKit

class MyCitiesCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel! {
        didSet {
            cityName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    @IBOutlet weak var emblemCityView: UIImageView! {
        didSet {
            self.emblemCityView.layer.borderColor = UIColor.white.cgColor
            self.emblemCityView.layer.borderWidth = 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        emblemCityView.clipsToBounds = true
        emblemCityView.layer.cornerRadius = emblemCityView.frame.width / 2
        emblemCityView.layer.backgroundColor = UIColor.white.cgColor
    }

}
