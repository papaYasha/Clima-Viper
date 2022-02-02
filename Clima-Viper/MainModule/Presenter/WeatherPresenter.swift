//
//  WeatherPresenter.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit

enum NetworkError: Error {
    case NetworkFailed
    case ParsingFailed
}

protocol WeatherPresenterInput {
    
}

protocol WeatherPresenterOutput: WeatherPresenterInput {
    
}
