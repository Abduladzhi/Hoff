//
//  ImageCollectionViewCell.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 25.04.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ImageCollectionViewCell.self)
    
    @IBOutlet weak var imageCollection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        imageCollection.backgroundColor = .blue
        
    }

}
