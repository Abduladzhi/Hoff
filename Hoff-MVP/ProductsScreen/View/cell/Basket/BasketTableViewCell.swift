//
//  BasketTableViewCell.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 12.04.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: BasketTableViewCell.self)
    
    @IBOutlet weak var imageBasket: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

}
