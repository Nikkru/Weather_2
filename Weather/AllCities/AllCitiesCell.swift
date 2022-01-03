//
//  AllCitiesCell.swift
//  Weather
//
//  Created by Nikolai Krusser on 05.11.2021.
//

import UIKit

class AllCitiesCell: UITableViewCell {

    @IBOutlet var cityTitleLabel: UILabel! {
        didSet {
            cityTitleLabel.textColor = #colorLiteral(red: 1, green: 0.9833967274, blue: 0.3201008165, alpha: 1)
        }
    }
    @IBOutlet var cityEmblemView: UIImageView! {
        didSet {
            self.cityEmblemView.layer.borderColor = UIColor.white.cgColor
            self.cityEmblemView.layer.borderWidth = 2
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

    
    func configure(city: String, emblem: UIImage) {
        self.cityTitleLabel.text = city
        self.cityEmblemView.image = emblem
        
        self.backgroundColor = UIColor.black
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityTitleLabel.text = nil
        self.cityEmblemView.image = nil
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
       
//        cityEmblemView.frame.size = CGSize(width: 100, height: 100)

        cityEmblemView.clipsToBounds = true
        cityEmblemView.layer.cornerRadius = cityEmblemView.frame.width / 2
        cityEmblemView.layer.backgroundColor = UIColor.white.cgColor
//        cityEmblemView.sizeToFit()
    }

}
