//
//  WeatherViewController.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit

protocol WeatherViewControllerInput {
    
}

class WeatherViewControllerOutput: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherConditionImage: UIImageView!
        
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    //MARK: - Functions
    
    private func config() {
        createDelegateAndDataSource()
        configTableView()
        configCollectionView()
    }
    
    private func createDelegateAndDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
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
    
    //MARK: - IBActions
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
    }
    
}

//MARK: - CollectionView Delegate & Data Source

extension WeatherViewControllerOutput: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

//MARK: - TableView Delegate & Data Source

extension WeatherViewControllerOutput: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
