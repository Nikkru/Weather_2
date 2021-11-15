//
//  FriendCollectionCell.swift
//  Weather
//
//  Created by Nikolai Krusser on 15.11.2021.
//

import UIKit

class FriendCollectionCell: UICollectionViewCell {
    
    var friendName: String?
    
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell(name: friendName)
    }

    func setupCell(name: String?) {
        guard let friendName = name else {
            return self.friendImage.image = UIImage(named: "anonymous")
        }
        self.friendImage.image = UIImage(named: friendName)
    }
}
