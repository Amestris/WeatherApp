//
//  WeatherModel.swift
//  Clima
//
//  Created by Ewelina on 29/12/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let weatherDesc: String
    
    var conditionName: String{
        switch conditionId{
        case 200...250:
            return "cloud.bolt.fill"
        case 300...350:
            return "cloud.drizzle.fill"
        case 500...501:
            return "cloud.rain.fill"
        case 511:
            return "cloud.sleet.fill"
        case 502...531:
            return "cloud.heavyrain.fill"
        case 612...616:
            return "cloud.sleet.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...711:
            return "smoke.fill"
        case 721:
            return "sun.haze.fill"
        case 731:
            return "sun.dust.fill"
        case 741:
            return "cloud.fog.fill"
        case 751...771:
            return "sun.dust.fill"
        case 772:
            return "tornado"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.sun.fill"
        default:
            return "questionmark"
        }
    }
    
}
