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
    
    var interactor: WeatherInteractor? {
        didSet {
            interactor?.performRequest(with: "https://api.openweathermap.org/data/2.5/onecall?exclude=alerts,minutely&appid=4922baab80f9593f292d4f39ce306359&units=metric", city: "Minsk")
        }
    }
    
    var view: WeatherView?
    
    func interactorDidDownloadWeather(result: Result<WeatherModel, Error>) {
        switch result {
        case .success(let weather):
            view?.didUpdateWeather(with: weather)
        case .failure(let error):
            view?.didUpdateWeather(with: error.localizedDescription)
        }
    }
}
