import Foundation
import Alamofire

class  NetworkService {
    static let shared = NetworkService()
    private init() {}
    let urlDomain = "https://dev-re-1.hoff.ru/api/v2/get_products_new"
    let urlCategory = "?category_id="
    let urlSortBy = "&sort_by="
    let urlSortType = "&sort_type="
    let urlLimit = "&limit="
    let urlOffset = "&offset="
    let urlDeviceID = "&device_id=3a7612bcc84813b5"
    let urlIsAdroid = "&isAndroid=true"
    let urlAppVersion = "&app_version=1.8.16"
    let urlLocation = "&location=19"
    let urlXHoff = "&xhoff=36f40b3d665cdb9435904796172dde5e3f13aa8a%3A4630"
    
    public func getTheFood(categoryId: String, sortBy: String, sortType: String, limit: String, offset: String, complition: @escaping(Data?) -> Void) {
        let url = urlDomain + urlCategory + categoryId + urlSortBy + sortBy + urlSortType + sortType + urlLimit + limit + urlOffset + offset + urlDeviceID
        AF.request(url).responseDecodable(of: Data.self) { (response) in
            complition(response.value)
        }
    }
}
