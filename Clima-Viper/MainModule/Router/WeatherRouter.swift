//
//  WeatherRouter.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit

typealias EntryPoint = WeatherView & UIViewController

protocol WeatherRouter {
    var entry: EntryPoint?{ get }
    static func startExecution() -> WeatherRouter
}
