//
//  RxNetworkService.swift
//  School
//
//  Created by Anna Vaganova on 15.04.2021.
//

import Alamofire
import Foundation
import RxSwift

struct RXNetworkServiceError: Error {
    var description: String?
}

class RxNetworkService {
    
    func getPlanetList(page: Int) -> Observable<PlanetListResponseModel> {
        let url = NetworkConstants.URLString.planetList + "\(page)"
        return performRequest(urlString: url)
    }
    
    private func performRequest <ResponseModel: Decodable> (urlString: String, method: HTTPMethod = .get, parameters: Parameters? = nil) -> Observable<ResponseModel> {
        
        Observable<ResponseModel>.create{
            (observer) -> Disposable in
            
            let request = AF.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .responseData {
                
                    (afDataResponse) in
                    guard let data = afDataResponse.data,
                          afDataResponse.error == nil
                    else {
                        let error = RXNetworkServiceError(description: afDataResponse.error?.errorDescription)
                        observer.onError(error)
                        return
                    }
                    
                    do {
                        let decodedValue: ResponseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                        observer.onNext(decodedValue)
                        observer.onCompleted()
                                        }
                    catch(let error) {
                        let error = RXNetworkServiceError(description: error.localizedDescription)
                        observer.onError(error)
                        return
                    }
            }
            
            let disposable = Disposables.create {
                request.cancel()
            }
            
            return disposable
        }
    }
}
