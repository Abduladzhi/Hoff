import Foundation

struct Data: Decodable {
    var totalCount: Int
    var items: [Items]?
//    var relatedCategories: [RelatedCategories]
//    var categoryName: String
//    var categoryUrl: String
}

struct Items: Decodable {
    var id: String
    var name: String
    var image: String
    var prices: Prices
    var discount: Int
//    var full_set_prices:
    
    var isBestPrice: Bool
    
    var tag: [Tag]?
    
    var isFavorite: Bool
    var articul: String
    var rating: Double
    var numberOfReviews: String
    var in_stock: Int
    var yellow: Bool
    var statusText: String
    var bonusesForbuy: Int
//    var deliveryTime: Int?
//    var is_it_kit: Int?
    
////    var offers_xml_ids:
//    var right_block_info
    ///
    var isAvailable: Bool
    
    var images: [String]
////    var complexAsOne:
    var categoryId: String
    var categoryTitle: String
    
    
    
    
}

struct Prices: Decodable {
    var new: Int
    var old: Int
}

struct Tag: Decodable {
    var text: String?
    var textColor: String?
    var bgColor: String?
    var message: String?
    var landingId: String?
    var link: String?
}
