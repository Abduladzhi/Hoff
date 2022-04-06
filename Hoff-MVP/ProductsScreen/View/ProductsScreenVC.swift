//
//  ProductsScreenVC.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import UIKit
import SDWebImage

class ProductsScreenVC: UIViewController {
    var buttonSortIsHidden = true
    var presenter: ProductsScreenPresenterProtocol!
    var tableList: UITableView = {
        let tableView = UITableView()
//        tableView.register( ,forCellReuseIdentifier: "tableSortCell")
//        tableView.register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "tableSortCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableSortCell")
        tableView.backgroundColor = .gray
        return tableView
    }()
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        view.addSubview(tableList)
        //        tableList.isHidden = buttonSortIsHidden
        tableList.delegate = self
        tableList.dataSource = self
        //        print(presenter.product?.totalCount)
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
        print(presenter.product?.totalCount)
        productCollectionView.reloadData()
    }
    
    func failure() {
        print("ПУсто")
    }
    
}

extension ProductsScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.product?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell)!
        let item = presenter.product?.items![indexPath.row]
        //        cell.backgroundColor = .red
        //        cell.nameLabel.text = item?.name
        cell.image.sd_setImage(with: URL(string: item?.image ?? ""))
        return cell
    }
    
    
}

extension ProductsScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableList.dequeueReusableCell(withIdentifier: "tableSortCell", for: indexPath)
        return cell
    }
    
    
}
