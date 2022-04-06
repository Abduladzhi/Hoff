//
//  MainScreenVC.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import UIKit

class MainScreenVC: UIViewController {

    var router: RouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressButton(_ sender: UIButton) {
        router.productScreen()
    }
    
}
