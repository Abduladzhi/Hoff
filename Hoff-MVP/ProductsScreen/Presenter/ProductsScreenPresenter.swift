//
//  ProductsScreenPresenter.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import Foundation
import ProgressHUD

protocol MainProtocol {
    func success()
    func failure()
}

protocol ProductsScreenPresenterProtocol: AnyObject {
    init(router: RouterProtocol, view: MainProtocol)
    var product: Data? { get set }
    func viewDidLoad()
    func getProduct(categoryId: String?, sortBy: String?, sortType: String?, limit: String?, offset: String?)
    func paginationActive()
//    func showDetail(item: Items)
    
}

class ProductsScreenPresenter: ProductsScreenPresenterProtocol {
    
    func viewDidLoad() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        getProduct(categoryId: nil, sortBy: nil, sortType: nil, limit: nil, offset: nil)
    }
    
    var changesToTheRequest = false
    
    func paginationActive(){
        
        getProduct(categoryId: nil, sortBy: nil, sortType: nil, limit: nil, offset: String(product?.items?.count ?? 0))
        
    }

//    func showDetail(item: Items) {
//        router.detailScreen(item: item)
//    }
    
    var product: Data?
    var router: RouterProtocol
    var view: MainProtocol?
    
    required init(router: RouterProtocol, view: MainProtocol) {
        
        self.router = router
        self.view = view
    }
    
    func getProduct(categoryId: String?, sortBy: String?, sortType: String?, limit: String?, offset: String?) {
           
           var categoryId = categoryId ?? ""
           var sortBy = sortBy ?? ""
           var sortType = sortType ?? ""
           var limit = limit ?? ""
           var offset = offset ?? ""
           
           if categoryId == "" {
                categoryId = "320"
           }
           if sortBy == "" {
                sortBy = "popular"
           }
           if sortType == "" {
                sortType = "desc"
           }
           if limit == "" {
                limit = "10"
           }
           if offset == "" {
                offset = "0"
           }
           
       
        
           NetworkService.shared.getTheFood(categoryId: categoryId, sortBy: sortBy, sortType: sortType, limit: limit, offset: offset) { response in
               if (response != nil) {
                   if self.changesToTheRequest == true && self.product == nil {
                       self.product = response
                       
                   }
                   if self.product == nil {
                       self.product = response
                       ProgressHUD.dismiss()
                   } else if self.changesToTheRequest == false {
                       self.product!.items = self.product!.items! + response!.items!
                       
                   } else {
                       self.product = response
                       
                   }
                   self.view?.success()
                   print("ne пусто")
               } else {
                   self.view?.failure()
                   print("пусто")
               }
           }
    }
}

//

