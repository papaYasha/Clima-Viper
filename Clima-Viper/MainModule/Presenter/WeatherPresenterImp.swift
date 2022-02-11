//
//  WeatherPresenterImp.swift
//  Clima-Viper
//
//  Created by Macbook on 3.02.22.
//

import UIKit
import CoreLocation

final class WeatherPresenterImp: WeatherPresenter {
    
    var router: WeatherRouter?
    var interactor: WeatherInteractor?
    var view: WeatherView?
    
    func interactorDidDownloadWeather(result: Result<WeatherModel, Error>, city: String) {
        switch result {
        case .success(let weather):
            view?.didUpdateWeather(with: weather)
        case .failure(let error):
            view?.didUpdateWeather(with: error.localizedDescription, city: city)
        }
    }
}
