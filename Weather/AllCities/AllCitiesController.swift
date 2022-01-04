//
//  AllCitiesController.swift
//  Weather
//
//  Created by Nikolai Krusser on 05.11.2021.
//

import UIKit
import SDWebImage

class AllCitiesController: UITableViewController {
    
    let urlTokio = "https://www.ph4.ru/DL/HERALD/CITIES/jp/arms_tokyo.gif"
    
    let dict: [String: String] = [
        "title": "Moscow", "emblemURL":  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_moscow_of.gif"
    ]
//    let c = CityModel(dict: dict)
var cities = [
    City(title: "Moscow", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_moscow_of.gif"),
    City(title: "Krasnoyarsk", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_krasnoyarsk.gif"),
    City(title: "London", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/uk/arms_london.gif"),
    City(title: "Paris", emblemURL:  "https://www.ph4.ru/DL/HERALD/DISTRICTS/fr/arms_paris.gif"),
    City(title: "Tokio", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/jp/arms_tokyo.gif")
]
    var citis = [
        (title: "Moscow", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_moscow_of.gif"),
        (title: "Krasnoyarsk", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/ru/arms_krasnoyarsk.gif"),
        (title: "London", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/uk/arms_london.gif"),
        (title: "Paris", emblemURL:  "https://www.ph4.ru/DL/HERALD/DISTRICTS/fr/arms_paris.gif"),
        (title: "Tokio", emblemURL:  "https://www.ph4.ru/DL/HERALD/CITIES/jp/arms_tokyo.gif")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "addCity" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow  else { return }
        let destinationVC: MyCitiesController = segue.destination as! MyCitiesController
        let city = cities[indexPath.row]
        if !destinationVC.cities.contains(city.title) {
            destinationVC.cities.append(city.title)
            destinationVC.tableView.reloadData()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func add(_ sender: Any) {
    }
    
}
