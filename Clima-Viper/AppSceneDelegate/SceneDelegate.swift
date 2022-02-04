//
//  SceneDelegate.swift
//  Clima-Viper
//
//  Created by Macbook on 20.01.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller =  storyboard.instantiateViewController(identifier: Constants.weatherViewControllerID) as? WeatherViewController else { return }

        let router = WeatherRouterImp()
        var view: WeatherView = WeatherViewController()
        var preseneter: WeatherPresenter = WeatherPresenterImp()
        var interactor: WeatherInteractor = WeatherInteractorImp()
        
        view.presenter = preseneter
        
        preseneter.view = view
        preseneter.router = router
        preseneter.interactor = interactor
        interactor.presenter = preseneter

        window.rootViewController = controller
        window.makeKeyAndVisible()
        self.window = window
    }
}

