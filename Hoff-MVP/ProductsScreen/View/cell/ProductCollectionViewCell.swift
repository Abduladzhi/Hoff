//
//  ProductCollectionViewCell.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 07.04.2022.
//

import UIKit
import Cosmos

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var oldLabel: UILabel!
    @IBOutlet weak var blackFRD: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    
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
    
    func productSetupCell(item: Items, cell: ProductCollectionViewCell) {
        setCosmosView(cell: cell)
        cosmosView.rating = item.rating
        cosmosView.text = item.numberOfReviews
        var myString = item.image
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
        image.sd_setImage(with: URL(string: myString))
        nameLabel.text = item.name
        blackFRD.text = item.tag?[0].text ?? ""
        count.text = item.statusText
        let newPrice = "\(item.prices.new)"
        let oldPrice = "\(item.prices.old)"
        
        let attributeString =  NSMutableAttributedString(string: "\(oldPrice) ₽")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        
        if item.isFavorite == true {
            buttonFavorite.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            buttonFavorite.imageView?.image = UIImage(systemName: "heart")
        }
        if item.prices.new == item.prices.old {
            newLabel.text = newPrice + "₽"
            oldLabel.isHidden = true
        } else {
            newLabel.text = newPrice + "₽"
            oldLabel.attributedText = attributeString
        }
    }

    
    
    
}
