//
//  DetailNewVCViewController.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 13.04.2022.
//

import UIKit

class DetailNewVCViewController: UIViewController {

    var items: Items!
    var itemsTwo: [String]!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        collectionView.isPagingEnabled = true
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    func setupVC() {
        pageControl.numberOfPages = itemsTwo.count
        label1.text = items.color
        label2.text = items.statusText
        labelVC.text = items.name
        var myString = items.image
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
//        imageVC.sd_setImage(with: URL(string: myString))
    }
    
    
}

extension DetailNewVCViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemsTwo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellCollectionViewCell.identifier, for: indexPath) as! ImageCellCollectionViewCell
        var myString = itemsTwo[indexPath.row]
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
//        imageVC.sd_setImage(with: URL(string: myString))
        cell.image.sd_setImage(with: URL(string: myString))
        return cell
    }

    
}
