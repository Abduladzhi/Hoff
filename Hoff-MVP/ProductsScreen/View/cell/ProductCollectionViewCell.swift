//
//  ProductCollectionViewCell.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 07.04.2022.
//

import UIKit
import Cosmos

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var oldLabel: UILabel!
    @IBOutlet weak var blackFRD: UILabel!
    @IBOutlet weak var count: UILabel!
    
    lazy var cosmosView: CosmosView = {
       var cosmos = CosmosView()
        cosmos.settings.updateOnTouch = false
        cosmos.settings.fillMode = .precise
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        return cosmos
    }()
    
    func setCosmosView(cell: ProductCollectionViewCell) {
        cell.addSubview(cosmosView)
        NSLayoutConstraint.activate([
            cosmosView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 12),
            cosmosView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -10)
        ])
        
    }
    

    
    
    
}
