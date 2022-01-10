//
//  MyCitiesController.swift
//  Weather
//
//  Created by Nikolai Krusser on 06.11.2021.
//

import UIKit
import RealmSwift

class MyCitiesController: UITableViewController {
    
    var citie: City?
    var cities = [City]()
    
    var cityes: Results<CityDAO>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = #colorLiteral(red: 0.2282898724, green: 0.4693045616, blue: 0.5696201921, alpha: 1)
        pairTableAndRealm()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let c = cityes else { return cities.count }
        guard c.count > 0 else { return cities.count }
        return c.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesCell", for: indexPath) as! MyCitiesCell
        if let c = cityes {
        let city = c[indexPath.row]
            if city.name != "" {
                cell.cityName.text = city.name }
//        cell.emblemCityView.image = city.emblemImage
        } else {
            let city = cities[indexPath.row]
            cell.cityName.text = city.title
            cell.emblemCityView.image = city.emblemImage
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCity" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow  else { return }
        let destinationVC: WeatherViewController = segue.destination as! WeatherViewController
        let city = cities[indexPath.row]
        destinationVC.citie = city
        destinationVC.cityName = city.title
//        destinationVC.weatherCollectionView.reloadData()
        
    }
    
    @IBAction func addCity(segue: UIStoryboardSegue) {
        
    }
}

extension MyCitiesController {
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        guard var cities = cityes else { return }
        cities = realm.objects(CityDAO.self)
        token = cities.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
