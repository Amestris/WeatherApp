//
//  WeatherManager.swift
//  Clima
//
//  Created by Ewelina on 20/12/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

protocol WeatherManagerDelegate{
    func updateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=API_KEY&units=metric&lang=pl"
    
    var delegate: WeatherManagerDelegate?
    
    
    func checkWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let url = weatherURL+"&lat=\(latitude)&lon=\(longitude)"
        print(url)
        performRequest(url)
    }
    func checkWeather(cityName: String){
        if let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = weatherURL+"&q=\(city)"
            performRequest(url)
        }
        
    }
    
    func performRequest(_ url: String){
        AF.request(url).validate().responseDecodable(of: WeatherData.self) { response in
            
            switch (response.result){
            
            case .success(_):
                do{
                    if let safeData = response.data{
                        if let weather =  self.parseJSON(safeData){
                            print(weather)
                            self.delegate?.updateWeather(weather)
                        }
                    }
                }
                
            case .failure(let error):
                self.delegate?.didFailWithError(error)

            }
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherCode = decodedData.weather[0].id
            let cityName = decodedData.name
            
            let temp = decodedData.main.temp.rounded(.up)
            
            let weatherModel = WeatherModel(conditionId: weatherCode, cityName: cityName, temperature: temp, weatherDesc: decodedData.weather[0].description)
            return weatherModel
        } catch {
            print(error)
            return nil
        }
        
    }
    
    
    
}
