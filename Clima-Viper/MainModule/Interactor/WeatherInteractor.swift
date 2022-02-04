//
//  Interactor.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit
import CoreLocation

protocol WeatherInteractor {
    var presenter: WeatherPresenter? { get set }
    var locationService: CLLocationService? {get set}
    
    func performRequest(with urlString: String, city: String)
    func parseJSON(_ weatherData: Data) -> WeatherModel?
    func fetchWeather(location: CLLocation)
    func fetchWeather(city: String)
    func getDayForDate(_ date: Date?) -> String
}
