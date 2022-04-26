//
//  ProductCollectionViewCell.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 07.04.2022.
//

import UIKit
import Cosmos
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    var itemsTwo: [String]!
    var items: Items!
    
    @IBOutlet weak var collectionViewImage: UICollectionView!
    
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
    

    
    @IBAction func buttonBasketPress(_ sender: Any) {
    }
    
    func setCosmosView(cell: ProductCollectionViewCell) {
        cell.addSubview(cosmosView)
        NSLayoutConstraint.activate([
            cosmosView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 12),
            cosmosView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -10)
        ])
        
    }
    
    func productSetupCell(item: Items, cell: ProductCollectionViewCell) {
        self.items = item
        
        collectionViewImage.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        setCosmosView(cell: cell)
        cosmosView.rating = item.rating
        cosmosView.text = item.numberOfReviews
        var myString = item.image
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
//        image.sd_setImage(with: URL(string: myString))
        nameLabel.text = item.name
        
        
        
        blackFRD.text = item.tag?[0].text
        
//        let darkGrey = UIColor(hexString: item.tag?[0].textColor ?? "")
        blackFRD.textColor = UIColor(hexString: item.tag?[0].bgColor ?? "")
        
        
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


extension ProductCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        var myString = items.images[indexPath.row]
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
//        imageVC.sd_setImage(with: URL(string: myString))
//        print(myString)
//        cell.imageCollection.sd_setImage(with: URL(string: myString))
        cell.imageCollection.kf.setImage(with: URL(string: myString))
        
        return cell
    }
    
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
