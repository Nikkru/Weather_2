//
//  MyCitiesController.swift
//  Weather
//
//  Created by Nikolai Krusser on 06.11.2021.
//

import UIKit

class MyCitiesController: UITableViewController {
    
    var citie: City?
    var emblemImage = UIImage()

    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesCell", for: indexPath) as! MyCitiesCell

        let city = cities[indexPath.row]
        cell.cityName.text = city.title
        cell.emblemCityView.image = city.emblemImage

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func addCity(segue: UIStoryboardSegue) {
//        // Проверяем идентификатор перехода, чтобы убедиться, что это нужный
//        if segue.identifier == "addCity" {
//            // Получаем ссылку на контроллер, с которого осуществлен переход
//            let allCitiesController = segue.source as! AllCitiesController
//
//            // Получаем индекс выделенной ячейки
//            if let indexPath = allCitiesController.tableView.indexPathForSelectedRow {
//                // Получаем город по индексу
//                let city = allCitiesController.cities[indexPath.row]
//
//                // Проверяем, что такого города нет в списке
//                if !(cities.first?.title.contains(city.title))! {
//                    // Добавляем город в список выбранных
//                    cities.append(city)
//                    // Обновляем таблицу
//                    tableView.reloadData()
//                }
//            }
//        }
//        if segue.identifier == "addCity" {
//            guard let allCitiesController = segue.source as? AllCitiesController else { return }
//            if let indexPath = allCitiesController.tableView.indexPathForSelectedRow {
//                let city = allCitiesController.cities[indexPath.row]
//                cities.append(city.title)
//                tableView.reloadData()
//            }
//        }
    }
}
