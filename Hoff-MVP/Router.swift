//
//  Router.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var navController: UINavigationController! { get set }
    var assedlerBuilder: AssedlerBuilderProtocol! { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewCotroller() -> UIViewController
    func productScreen()
//    func detailScreen(item: Items)
}

class Router: RouterProtocol {
    var assedlerBuilder: AssedlerBuilderProtocol!
    
    var navController: UINavigationController!
    
    func initialViewCotroller() -> UIViewController {
        let mainViewController = assedlerBuilder.createMainScreeb(router: self)
     return mainViewController
    }
    
    func productScreen(){
        let productViewController = assedlerBuilder.createProductScreen(router: self)
        navController.pushViewController(productViewController, animated: true)
    }
    
//    func detailScreen(item: Items) {
//        let detailViewController = assedlerBuilder.createDetail(router: self, item: item)
//        navController.pushViewController(detailViewController, animated: true)
//    }
    
    init(navController: UINavigationController, assedlerBuilder: AssedlerBuilderProtocol) {
        self.navController = navController
        self.assedlerBuilder = assedlerBuilder
    }
    

    
    
    
}
