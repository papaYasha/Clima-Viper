//
//  CollectionViewCell.swift
//  Clima-Viper
//
//  Created by Macbook on 2.02.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: CollectionViewCell.self)
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    
    func config() {
        
    }

}
