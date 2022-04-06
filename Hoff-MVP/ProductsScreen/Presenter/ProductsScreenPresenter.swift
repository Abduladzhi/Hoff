//
//  ProductsScreenPresenter.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 06.04.2022.
//

import Foundation

protocol MainProtocol {
    func success()
    func failure()
}

protocol ProductsScreenPresenterProtocol: AnyObject {
    init(router: RouterProtocol, view: MainProtocol)
    var product: Data? { get set }
    func viewDidLoad()
    func getProduct(categoryId: String?, sortBy: String?, sortType: String?, limit: String?, offset: String?)
}

class ProductsScreenPresenter: ProductsScreenPresenterProtocol {
    func viewDidLoad() {
        getProduct(categoryId: nil, sortBy: "price", sortType: nil, limit: nil, offset: nil)
    }
    
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
                limit = "40"
           }
           if offset == "" {
                offset = "0"
           }
           
           
           
           NetworkService.shared.getTheFood(categoryId: categoryId, sortBy: sortBy, sortType: sortType, limit: limit, offset: offset) { response in
//               print(response)
               if (response != nil) {
                   
//                   if self.product == nil {
                   self.product = response
//                   } else {
//                       self.product!.items = self.product!.items + response!.items
//                   }
                   self.view?.success()
               } else {
                   self.view?.failure()
                   print("пусто")
               }
           }
       }
    
}
