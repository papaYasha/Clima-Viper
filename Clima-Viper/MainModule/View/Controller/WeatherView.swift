//
//  WeatherView.swift
//  Clima-Viper
//
//  Created by Macbook on 3.02.22.
//

import Foundation

protocol WeatherView {
    var presenter: WeatherPresenter? { get set }
    
    func didUpdateWeather(with model: WeatherModel)
    func didUpdateWeather(with error: String, city: String)
}
