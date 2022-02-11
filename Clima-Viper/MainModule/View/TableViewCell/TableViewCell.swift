//
//  TableViewCell.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TableViewCell.self)
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    func config(with model: WeatherModelDaily) {
        dayLabel.text = model.time
        iconImage.image = UIImage(systemName: model.conditionName)
        minTempLabel.text = model.minTemperatureString
        maxTempLabel.text = model.maxTemperatureString
    }
}
