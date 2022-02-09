//
//  WeatherPresenter.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit
import CoreLocation

enum NetworkError: Error {
    case NetworkFiled
    case ParsingFailed
}

protocol WeatherPresenter {
    var router: WeatherRouter? { get set }
    var interactor: WeatherInteractor? { get set }
    var view: WeatherView? { get set }
    
    func interactorDidDownloadWeather(result: Result<WeatherModel, Error>, city: String)
}
