//
//  DetailVCViewController.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 12.04.2022.
//

import UIKit

class DetailVCViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    
    var items: Items!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        var myString = items.image
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
        detailImage.sd_setImage(with: URL(string: myString))
        detailLabel.text = items.name
    }
}
