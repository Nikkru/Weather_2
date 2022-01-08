//
//  WeatherDataBase.swift
//  Weather
//
//  Created by Nikolai Krusser on 08.01.2022.
//

import Foundation
import RealmSwift

final class WeatherDataBase {
    
    init() {
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
    }
    
    func save(_ items: [Weather]) {
        
//        Если в каждом методе ижет свой Realm, можно создавать объект ассинхронно через try!
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        guard  let url = realm.configuration.fileURL else { return }
        print(url)
    }
    
    func fetch() -> Results<Weather> {
        let realm = try! Realm()
        
        let friends: Results<Weather> = realm.objects(Weather.self)
        return friends
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func delete(_ item: Weather) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
    
    //сохранение погодных данных в Realm
        func saveWeatherData(_ weathers: [Weather]) {
    // обработка исключений при работе с хранилищем
            do {
    // получаем доступ к хранилищу
                let realm = try Realm()
                
    // начинаем изменять хранилище
                realm.beginWrite()
                
    // кладем все объекты класса погоды в хранилище
                realm.add(weathers)
                
    // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
}
