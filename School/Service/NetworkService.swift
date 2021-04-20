//
//  NetworkService.swift
//  School
//
//  Created by Anna Vaganova on 05.04.2021.
//

import Foundation
import Alamofire

class NetworkService: PlanetsListNetworkService {
    func getPlanetList(page: Int, onRequestCompleted: @escaping ((PlanetListResponseModel?, Error?) -> ())) {
        performRequest(urlString: NetworkConstants.URLString.planetList+"?page=\(page)", onRequestCompleted: onRequestCompleted)
    }
    
    private func performRequest <ResponseModel: Decodable> (urlString: String, method: HTTPMethod = .get, onRequestCompleted: @escaping ((ResponseModel?, Error?)->())) {
        AF.request(urlString,
                   method: method,
                   encoding: JSONEncoding.default).response { (responseData) in
                    guard responseData.error == nil,
                          let data = responseData.data,
                          data.count != 0
                    else {
                        onRequestCompleted(nil, responseData.error)
                        return
                    }
                    
                    do {
                        let decodedValue: ResponseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                                        onRequestCompleted(decodedValue, nil)
                    }
                    catch (let error) {
                        print("Response parsing error: \(error.localizedDescription)")
                        onRequestCompleted(nil, error)
                    }
                   }
    }
}
