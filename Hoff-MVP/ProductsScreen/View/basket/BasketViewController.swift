//
//  BasketViewController.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 12.04.2022.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var basket: [Items]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Корзина"
//        tableView.backgroundColor = .red
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: BasketTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BasketTableViewCell.identifier)
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier) as! BasketTableViewCell
//        let items = item[indexPath.row]
//        cell.setup(items: items)
        cell.titleLabel.text = "111"
        return cell
    }
    
    
}
