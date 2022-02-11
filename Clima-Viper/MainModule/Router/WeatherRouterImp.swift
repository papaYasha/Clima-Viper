//
//  WeatherRouterImp.swift
//  Clima-Viper
//
//  Created by Macbook on 3.02.22.
//

import Foundation

final class WeatherRouterImp: WeatherRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> WeatherRouter {
        
        let router = WeatherRouterImp()
        var view: WeatherView = WeatherViewController()
        var preseneter: WeatherPresenter = WeatherPresenterImp()
        var interactor: WeatherInteractor = WeatherInteractorImp()
        
        view.presenter = preseneter
        preseneter.view = view
        preseneter.router = router
        preseneter.interactor = interactor
        interactor.presenter = preseneter


        return router
    }
}
