//
//  BaseRequest.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkResult<T> {
    case success(T)
    case failure(String?)
}

class BaseNetwork {
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    public enum QueryType {
        case json, normal
    }
    
    @discardableResult
    static func request<T: BaseRequest>(req: T, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let url = req.setUrl()
        let request = prepareRequest(for: url, req: req)
        
        return AF.request(request).responseJSON { (response) in
            if let json = response.value {
                print("JSON: \(JSON(json)) ")
            }
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
            
            if let responseCode = response.response {
                switch responseCode.statusCode {
                case 200:
                    if let data = response.data {
                        let decoder = JSONDecoder()
                        do {
                            let object = try decoder.decode(T.ResponseType.self, from: data)
                            completionHandler(NetworkResult.success(object))
                        } catch let error {
                            completionHandler(NetworkResult.failure(error.localizedDescription))
                        }
                    }
                case 401, 404:
                    let jsonResult = JSON(response.value as Any)
                    completionHandler(NetworkResult.failure(jsonResult["status_message"].stringValue))
                default:
                    completionHandler(NetworkResult.failure(Constant.FAILED_REQUEST))
                }
            }
        }
    }
}

extension BaseNetwork {
    
    private static func prepareRequest<T: BaseRequest>(for url: URL, req: T) -> URLRequest {
        
        var request : URLRequest? = nil
        
        request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request!.httpMethod = req.method().rawValue
        
        return request!
    }
}

