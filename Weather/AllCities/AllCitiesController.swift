//
//  AllCitiesController.swift
//  Weather
//
//  Created by Nikolai Krusser on 05.11.2021.
//

import UIKit
import SDWebImage

class AllCitiesController: UITableViewController {

var cities = [
    City(title: "Moscow", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_moscow_of.gif", emblemImage: #imageLiteral(resourceName: "01d")),
    City(title: "Krasnoyarsk", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_krasnoyarsk.gif", emblemImage: #imageLiteral(resourceName: "01d")),
    City(title: "London", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/uk/arms_london.gif", emblemImage: #imageLiteral(resourceName: "01d")),
    City(title: "Paris", emblemURL:  "https://www.ph4.ru/DL/HERALD/DISTRICTS/fr/arms_paris.gif", emblemImage: #imageLiteral(resourceName: "01d")),
    City(title: "Tokio", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/jp/arms_tokyo.gif", emblemImage: #imageLiteral(resourceName: "01d"))
]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = #colorLiteral(red: 0.2282898724, green: 0.4693045616, blue: 0.5696201921, alpha: 1)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! AllCitiesCell
        // Получаем город для конкретной строки
        let city = cities[indexPath.row]
        
        // Устанавливаем город в надпись ячейки
        cell.cityTitleLabel.text = city.title
        
        if let url = URL(string: city.emblemURL) {

            cell.cityEmblemView?.sd_setImage(with: url) { (image, _, _, _) in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            cities[indexPath.row].emblemImage = cell.cityEmblemView.image
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "addCity" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow  else { return }
        let destinationVC: MyCitiesController = segue.destination as! MyCitiesController
        let city = cities[indexPath.row]
        if ((destinationVC.cities.first(where: { $0.title == city.title }) == nil)) {
            destinationVC.cities.append(city)
            destinationVC.tableView.reloadData()
        }
    }
    
    @IBAction func add(_ sender: Any) {
    }
    
}
