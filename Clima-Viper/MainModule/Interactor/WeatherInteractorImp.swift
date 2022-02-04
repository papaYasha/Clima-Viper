//
//  WeatherInteractorImp.swift
//  Clima-Viper
//
//  Created by Macbook on 3.02.22.
//

import UIKit
import CoreLocation

final class WeatherInteractorImp: WeatherInteractor {
        
    var presenter: WeatherPresenter?
    var locationService: CLLocationService?
    
    func performRequest(with urlString: String, city: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Creathe a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                if error != nil {
                    //if userDefaults.isEmpty { didFailWithError } else {
                    //userDefaults.getValue(weatherModel)
                    //delegate.didUpdateWeather
                    //}
                    self?.presenter?.interactorDidDownloadWeather(result: .failure(NetworkError.NetworkFiled))
                    return
                }
                
                if let safeData = data {
                    if var weather = self?.parseJSON(safeData) {
                        weather.city = city
                        self?.presenter?.interactorDidDownloadWeather(result: .success(weather))
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let currentID = decodedData.current.weather[0].id
            let currentTemp = decodedData.current.temp
            let currentSunrise = getDayForDate(Date(timeIntervalSince1970: Double(decodedData.current.sunrise)))
            let currentSunset = getDayForDate(Date(timeIntervalSince1970: Double(decodedData.current.sunset)))
            let currentWindSpeed = decodedData.current.wind_speed
            let hourly = decodedData.hourly.map{ WeatherModelHourly(temp: $0.temp, time: $0.dt, conditionID: $0.weather[0].id) }
            let daily = decodedData.daily.map{ WeatherModelDaily(time: $0.dt, minTemp: $0.temp.min, maxTemp: $0.temp.max, conditionID: $0.weather[0].id) }
            let weather = WeatherModel(conditionID: currentID, temperature: currentTemp, sunrise: currentSunrise, sunset: currentSunset, windSpeed: currentWindSpeed, hourly: hourly, daily: daily)
            return weather
        } catch {
            self.presenter?.interactorDidDownloadWeather(result: .failure(NetworkError.ParsingFailed))
            return nil
        }
    }
    
    func fetchWeather(location: CLLocation) {
        let urlString = "\(Constants.weatherURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
        locationService?.getAddressFrom(location: location) { place, error in
            guard let place = place?[0], error == nil else { return }
            if let locality = place.locality {
                self.performRequest(with: urlString, city: locality)
            }
        }
    }
    
    func fetchWeather(city: String) {
        locationService?.getCoordinateFrom(address: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            let lat = coordinate.latitude
            let lon = coordinate.longitude
            let urlString = "\(Constants.weatherURL)&lat=\(lat)&lon=\(lon)"
            self.performRequest(with: urlString, city: city)
        }
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: inputDate)
    }
}
