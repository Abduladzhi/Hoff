//
//  ProductsScreenVC.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import UIKit
import SDWebImage
import Cosmos
import SwiftUI

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
    
    let buttonCollections = [FilderProduct.cornerTkan, FilderProduct.pramieLisher, FilderProduct.cornerLither] as [Any]
    
    enum ProductSort: String, CaseIterable {
        case cheapFirst = "Сначала дешевые"
        case dearOnesАirst = "Сначала дорогие"
        case popular = "Популярные товары"
        case byDiscount = "По скидкам"
    }
    enum FilderProduct: String, CaseIterable {
        case cornerTkan = "Угловые тканевые"
        case pramieLisher = "Прямые кожанные"
        case cornerLither = "Угловые кожанные"
    }
    
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        buttonCollectionView.register(UINib(nibName: ButtonCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        productCollectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        view.addSubview(tableList)
        
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
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case productCollectionView:
            return presenter.product?.items?.count ?? 0
        case buttonCollectionView:
            return buttonCollections.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case productCollectionView:
            let controller = DetailVCViewController.instantiate()
            let item = presenter.product?.items![indexPath.row]
            controller.items = item
            navigationController?.pushViewController(controller, animated: true)
        case buttonCollectionView: return
            
        default:
            return
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case productCollectionView:
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell)!
//            let rate = presenter.product?.items?.filter { $0.categoryTitle == "Угловые тканевые диваны" }
            let item = presenter.product?.items?[indexPath.row]
            cell.productSetupCell(item: item!, cell: cell)
            return cell
        case buttonCollectionView:
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell)!
            cell.backgroundColor = .gray
            let names = buttonCollections[indexPath.row]
            cell.buttonOutlet.setTitle("\(names)", for: .normal)
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == self.buttonCollectionView {
//            switch indexPath.row {
//            case 0:
//                presenter.product?.items = []
//                productCollectionView.reloadData()
//                presenter.product?.items.map{}
//            case 1: print("касание есть2")
//            default: print("касание есть вуафгде")
//            }
//        }
//    }
//    
//    
    
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
            presenter.product?.items = []
            productCollectionView.reloadData()
            presenter.getProduct(categoryId: nil, sortBy: "price", sortType: "asc", limit: nil, offset: nil)
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
