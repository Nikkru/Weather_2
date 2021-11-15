//
//  MyFriendController.swift
//  Weather
//
//  Created by Nikolai Krusser on 15.11.2021.
//

import UIKit

class MyFriendController: UIViewController{
    
    @IBOutlet weak var friendCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем нашу ячейку в коллекции
        self.friendCollectionView.register(UINib(nibName: "FriendCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FriendCollectionCell")
        self.friendCollectionView.dataSource = self
        
    }
}

extension MyFriendController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCell", for: indexPath) as! FriendCollectionCell
        return cell
    }
    
    
}
