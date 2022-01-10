//
//  WeatherViewController.swift
//  Weather
//
//  Created by Nikolai Krusser on 13.12.2021.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {

     var cityName: String?
    var citie: City?
    var cities = [City]()
    
    let weatherService = WeatherApi()
    var weathers = [Weather]()
    
    @IBOutlet weak var weekDayPicker: UIView!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let name = cityName else {
            return cityName = "Moscow"
        }
        weatherService.loadWeatherData(city: name) { [weak self] in
            
//            // сохраняем полученные данные в массиве, чтобы коллекция могла получить к ним доступ
//                self?.weathers = weathers
//            // коллекция должна прочитать новые данные
//                self?.weatherCollectionView?.reloadData()
            
            self?.loadData()
            
            self?.weatherCollectionView?.reloadData()
            }
    }
}
extension WeatherViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell",
                                                      for: indexPath) as! WeatherCell
        // Configure the cell
        cell.configure(whithWeather: weathers[indexPath.row])
        weatherCollectionView.reloadItems(at: [indexPath])
        
        return cell
    }
    
    func loadData() {
            do {
                let realm = try Realm()
                
                let weathers = realm.objects(Weather.self).filter("city == %@", cityName!)
                
                self.weathers = Array(weathers)
                
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }

}

extension WeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }

}
