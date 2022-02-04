//
//  WeatherViewController.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, WeatherView {

    //MARK: - IBOutlets
    
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var leadingViewMainInfo: UIView!
    
    var weatherModel: WeatherModel?
    var locationManager = CLLocationManager()
    var presenter: WeatherPresenter?
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    //MARK: - Functions
    
    private func config() {
        createDelegateAndDataSource()
        configCoreLocation()
        configTableView()
        configCollectionView()
        configLeadingViewMainInfo()
    }
    
    private func createDelegateAndDataSource() {
        locationManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
    }
    
    private func configTableView() {
        let nib = UINib(nibName: TableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func configCollectionView() {
        let nib = UINib(nibName: CollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func configLeadingViewMainInfo() {
        leadingViewMainInfo.layer.borderWidth = 2
        leadingViewMainInfo.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    private func configCoreLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func showAlert() {
        func showAlert() {
            let alert = UIAlertController(title: "No results found for \"\(searchTextField.text ?? "non-existing city")\"", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("You choose OK")
            }))
            self.present(alert, animated: true)
        }
    }
    
    func didUpdateWeather(with model: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherModel = model
            self.cityLabel.text = model.city
            self.weatherConditionImage.image = UIImage(systemName: model.conditionName)
            self.windSpeedLabel.text = String(model.windSpeed)
            self.sunriseLabel.text = model.sunrise
            self.sunsetLabel.text = model.sunset
            self.degreeLabel.text = model.temperatureString
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    func didUpdateWeather(with error: String) {
        DispatchQueue.main.async {
            self.showAlert()
        }
    }

    //MARK: - IBActions
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
}

//MARK: - CollectionView Delegate & Data Source

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weatherModel?.hourly.count ?? 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        if let safeWeatherModel = weatherModel {
            cell.config(with: safeWeatherModel.hourly[indexPath.row])
        }
        return cell
    }
}

//MARK: - TableView Delegate & Data Source

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel?.daily.count ?? 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        if let safeWeatherModel = weatherModel {
            cell.config(with: safeWeatherModel.daily[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
}

//MARK: - TextField Delegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = searchTextField.text {
            presenter?.interactor?.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - Location Delegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat,lon)
            presenter?.interactor?.fetchWeather(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


