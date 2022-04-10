//
//  ProductsScreenVC.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import UIKit
import SDWebImage
import Cosmos

class ProductsScreenVC: UIViewController {
    var buttonSortIsHidden = true
    var presenter: ProductsScreenPresenterProtocol!
    
    var tableList: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableSortCell")
        tableView.backgroundColor = .gray
        tableView.isHidden = true
        return tableView
    }()
    let buttons = [ProductSort.cheapFirst.rawValue, ProductSort.dearOnesАirst.rawValue, ProductSort.popular.rawValue, ProductSort.byDiscount.rawValue] as [Any]
    
    enum ProductSort: String, CaseIterable {
        case cheapFirst = "Сначала дешевые"
        case dearOnesАirst = "Сначала дорогие"
        case popular = "Популярные товары"
        case byDiscount = "По скидкам"
    }
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        view.addSubview(tableList)
        
        
        //        tableList.isHidden = buttonSortIsHidden
        tableList.delegate = self
        tableList.dataSource = self
    }
    
    
    
    
    @IBAction func pressLeftButton(_ sender: Any) {
        
        if buttonSortIsHidden {
            buttonSortIsHidden = !buttonSortIsHidden
            tableList.isHidden = buttonSortIsHidden
        } else {
            buttonSortIsHidden = !buttonSortIsHidden
            tableList.isHidden = buttonSortIsHidden
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableList.translatesAutoresizingMaskIntoConstraints = false
        tableList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableList.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

extension ProductsScreenVC: MainProtocol {
    func success() {
        productCollectionView.reloadData()
    }
    
    func failure() {
        print("Пусто")
    }
    
}

extension ProductsScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row  == (presenter.product?.items?.count ?? 0) - 1 && indexPath.row != 0 {
                print("END")
            presenter.paginationActive()
                print( indexPath.row)
    //            collectionView.contentInset.bottom = 140.0
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.product?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell)!
        let item = presenter.product?.items![indexPath.row]
        var myString = item?.image ?? ""
        let ix = myString.startIndex
        let ix2 = myString.index(ix, offsetBy: 8)
        let ix3 = myString.index(ix, offsetBy: 16)
        myString.removeSubrange(ix2...ix3)
        cell.image.sd_setImage(with: URL(string: myString))
        cell.nameLabel.text = item?.name
        cell.blackFRD.text = item?.tag?[0].text ?? ""
        cell.count.text = item?.statusText
        let newPrice = "\(item?.prices.new ?? 0)"
        let oldPrice = "\(item?.prices.old ?? 0)"
        
        let attributeString =  NSMutableAttributedString(string: "\(oldPrice) ₽")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        
        cell.setCosmosView(cell: cell)
        cell.cosmosView.rating = item?.rating ?? 0.0
        cell.cosmosView.text = item?.numberOfReviews
        if item?.prices.new == item?.prices.old {
            cell.newLabel.text = newPrice + "₽"
            cell.oldLabel.isHidden = true
        } else {
            cell.newLabel.text = newPrice + "₽"
            cell.oldLabel.attributedText = attributeString
        }
        return cell
    }
    
    
    
}

extension ProductsScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductSort.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableList.dequeueReusableCell(withIdentifier: "tableSortCell", for: indexPath)
        let ttt = buttons[indexPath.row]
        cell.textLabel?.text = String("\(ttt)")
        return cell
    }
    
    func oneHidden() {
        buttonSortIsHidden = !buttonSortIsHidden
        tableList.isHidden = buttonSortIsHidden
    }
    
    func secondHidden() {
        buttonSortIsHidden = !buttonSortIsHidden
        tableList.isHidden = buttonSortIsHidden
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
//            productCollectionView.reloadData()
            presenter.product?.items = []
            productCollectionView.reloadData()
            presenter.getProduct(categoryId: nil, sortBy: "price", sortType: "asc", limit: nil, offset: nil)
//            productCollectionView.reloadData()
            if buttonSortIsHidden {
                oneHidden()
            } else {
                secondHidden()
            }
        case 1:
            presenter.product?.items = []
            productCollectionView.reloadData()
            presenter.getProduct(categoryId: nil, sortBy: "price", sortType: "desc", limit: nil, offset: nil)
            if buttonSortIsHidden {
                oneHidden()
            } else {
                secondHidden()
            }
        case 2:
            presenter.product?.items = []
            productCollectionView.reloadData()
            presenter.getProduct(categoryId: nil, sortBy: "popular", sortType: "desc", limit: nil, offset: nil)
            if buttonSortIsHidden {
                oneHidden()
            } else {
                secondHidden()
            }
        case 3:
            presenter.product?.items = []
            productCollectionView.reloadData()
            presenter.getProduct(categoryId: nil, sortBy: "discount", sortType: "desc", limit: nil, offset: nil)
            if buttonSortIsHidden {
                oneHidden()
            } else {
                secondHidden()
            }
        default:
            presenter.product?.items = []
            productCollectionView.reloadData()
            presenter.getProduct(categoryId: nil, sortBy: nil, sortType: nil, limit: nil, offset: nil)
            if buttonSortIsHidden {
                oneHidden()
            } else {
                secondHidden()
            }
        }
        
    }
}
