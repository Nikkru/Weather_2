//
//  WeatherViewController.swift
//  Weather
//
//  Created by Nikolai Krusser on 13.12.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    let weatherService = WeatherApi()
    
    @IBOutlet weak var weekDayPicker: UIView!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherService.loadWeatherData(city: "Moscow")
    }
}
extension WeatherViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell",
                                                      for: indexPath) as! WeatherCell
        // Configure the cell
        cell.weather.text = "30"
        cell.time.text = "30.08.2017 18:00"
        
        return cell
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }

}
