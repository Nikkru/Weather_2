//
//  WeatherService.swift
//  Weather
//
//  Created by Nikolai Krusser on 07.01.2022.
//

import UIKit
import Alamofire
import RealmSwift

class WeatherApi {
    
    // базовый URL сервиса
    let baseUrl = "http://api.openweathermap.org"
    // ключ для доступа к сервису
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    let weatherApiKey = "92a1c5b7d7998aa81aef567739875fa3"
    var weathers = [Weather]()
    
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
    
    // метод для загрузки данных, в качестве аргументов получает город
    func loadWeatherData(city: String, completion: @escaping ([Weather]) -> Void) {
        
        // путь для получения погоды за 5 дней
        let path = "/data/2.5/forecast"
        // параметры, город, единицы измерения градусы, ключ для доступа к сервису
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": weatherApiKey
        ]
        
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            
            self.saveWeatherData(weather)
            
            completion(weather)
        }
    }
}
