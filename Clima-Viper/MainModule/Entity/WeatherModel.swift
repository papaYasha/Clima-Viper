//
//  WeatherModel.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit

//MARK: - WeatherModelCurrent

struct WeatherModel: Codable {
    let conditionID: Int
    let temperature: Double
    var city: String = ""
    let sunrise: String
    let sunset: String
    let windSpeed: Double
    let hourly: [WeatherModelHourly]
    let daily: [WeatherModelDaily]
    
    
    var temperatureString: String {
        return String(Int(temperature))
    }
    
    var conditionName: String {
        weatherID(id: conditionID)
    }
}

//MARK: - WeatherModelDaily

struct WeatherModelDaily: Codable {
    let time: String
    let minTemp: Double
    let maxTemp: Double
    let conditionID: Int
    
    init(time: Int64, minTemp: Double, maxTemp: Double, conditionID: Int) {
        self.time = WeatherModelDaily.getDayOfWeekFromDate(Date(timeIntervalSince1970: Double(time)))
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.conditionID = conditionID
    }
    
    var conditionName: String {
        weatherID(id: conditionID)
    }
    
    var maxTemperatureString: String {
        return String(Int(maxTemp))
    }
    
    var minTemperatureString: String {
        return String(Int(minTemp))
    }
    
    static func getDayOfWeekFromDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
}

//MARK: - WeatherModelHourly

struct WeatherModelHourly: Codable {
    let temp: Double
    let time: String
    let conditionID: Int
    
    init(temp: Double, time: Int64, conditionID: Int) {
        self.temp = temp
        self.time = WeatherModelHourly.getTimeFromDate((Date(timeIntervalSince1970: Double(time))))
        self.conditionID = conditionID
    }
    
    var conditionName: String {
        weatherID(id: conditionID)
    }
    
    var temperatureString: String {
        return String(Int(temp))
    }
    
    
   static func getTimeFromDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: inputDate)
    }
}

//MARK: - Switch weather image

func weatherID(id: Int) -> String {
    switch id {
    case 200...202:
        return "cloud.bolt.rain"
    case 210...221:
        return "cloud.bolt"
    case 230...232:
        return "cloud.bolt.rain"
    case 300...311:
        return "cloud.drizzle"
    case 312...321:
        return "cloud.heavyrain"
    case 500...501:
        return "cloud.rain"
    case 502...531:
        return "cloud.heavyrain"
    case 600...601:
        return "snow"
    case 602...622:
        return "cloud.snow"
    case 701...781:
        return "cloud.bolt"
    case 800:
        return "icloud.slash"
    case 801:
        return "cloud.sun"
    case 802...804:
        return "cloud"
    default:
        return "cloud"
    }
}
