//
//  ModulBuilder.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import Foundation
import UIKit

protocol AssedlerBuilderProtocol {
    func createMainScreeb(router: RouterProtocol) -> UIViewController
    func createProductScreen(router: RouterProtocol) -> UIViewController
}

class AssedlerScreenBuilder: AssedlerBuilderProtocol {
    
    func createMainScreeb(router: RouterProtocol) -> UIViewController {
        let view = MainScreenVC()
        view.router = router
        return view
    }
    
    func createProductScreen(router: RouterProtocol) -> UIViewController {
        let view = ProductsScreenVC()
        let presenter = ProductsScreenPresenter(router: router, view: view)
        view.presenter = presenter
        return view
    }
    
    
}

