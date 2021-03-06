//
//  ForecastViewModel.swift
//  WeatherForecast
//
//  Created by 1276121 on 13/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import SwiftUI
import Combine

class ForecastViewModel: ObservableObject {
    var weatherService: Services
    var cityName: String = "Boston"
    @Published var isValid: Bool = false
    @Published var weatherForCast = ForecastWeatherResponse()
    
    init() {
        self.weatherService = Services()
    }
    
    var currentCity: String {
        if let city = weatherForCast.name {
            return city
        } else {
            return ""
        }
    }
    
    var currentCountry: String {
        if let country = weatherForCast.sys?.country {
            return country
        } else {
            return""
        }
    }
    
    var weatherDay: String {
        if let day = weatherForCast.dt {
            let formattedDay = Helper().timeConverter(timeStamp: day, isDay: false)
            return formattedDay
        } else {
            return ""
        }
    }
    
    var temperature: String {
        if let temp = weatherForCast.main?.temp {
            let formattedString = String(format: "%.0f", temp)
            return formattedString + "°"
        } else {
            return ""
        }
    }
    
    var weatherDescription: String {
        if let desc = weatherForCast.weather?.first?.description {
            print(desc)
            return desc.capitalized(with:.current)
        } else {
            return ""
        }
    }
    
    
    var windSpeed: String {
        if let wind = weatherForCast.wind?.speed {
            let formattedWindSpeed = String(format: "%.1f", (wind))
            return  formattedWindSpeed + "mi/h"
        } else {
            return ""
        }
    }
    
    
    var tempMax: String {
        if let temp = weatherForCast.main?.temp_max {
            let formattedString = String(format: "%.0f", temp)
            return formattedString + "°"
        } else {
            return ""
        }
    }
    
    var humidity: String {
        if let humidity = weatherForCast.main?.humidity {
            let formattedWindhumidity = String(humidity)
            return  formattedWindhumidity + ""
        } else {
            return ""
        }
    }
    
    var date: Int {
        if let day = weatherForCast.dt {
            return day
        } else {
            return 0
        }
    }
    
    func searchCity() {
        if let city = self.cityName
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeatherForecast(by: city)
        }
    }
    
    func fetchWeatherForecast(by city: String) {
        self.weatherService.getWeatherData(city: cityName, success: { forecast in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    self.weatherForCast = forecast
                }
            }
        }, failure: { error in
            guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
                return
            }
            
            self.isValid = true
        })
    }
    
    
}
