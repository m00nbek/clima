//
//  WeatherManager.swift
//  Clima
//
//  Created by Oybek on 1/28/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import Alamofire
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f3a332550b4de4ed257c259c4c505bdc&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(lon: Double, lat: Double) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    var delegate: WeatherManagerDelegate?
    func performRequest(with urlString: String) {
        AF.request(urlString).response { response in
            if response.error != nil {
                self.delegate?.didFailWithError(error: response.error!)
                return
            }
            guard let data = response.data else {return}
            if let weather = parseJSON(data) {
                self.delegate?.didUpdateWeather(self, weather: weather)
            }
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
    
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, tempurature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
