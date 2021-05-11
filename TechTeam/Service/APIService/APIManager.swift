//
//  APIManager.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

class APIManager {
        
    // return resutl
    enum ApiResult<T> {
        case success(T)
        case failure(RequestError)
    }
    
    /// endpoints
    enum EndpointType {
        case getBaseDescription
        case getImage
    }
    
    /// errors
    enum RequestError {
        case invalidURL
        case unknownError
        case connectionError
        case authorizationError
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
    }
    
    static let baseUrl = "https://www.cleanappcode.com/testing/teach_team"
    
    static func getResource(type: EndpointType, imageName: String = "") -> String {
        switch type {

        case .getBaseDescription:
            return "\(APIManager.baseUrl)/api/getEmployeesData/"

        case .getImage:
            return "\(APIManager.baseUrl)/resource/\(imageName).jpg"
        }
    }
    
    /// load image from endpoint and save it inside shared cache
    static func loadImage(endpointType: EndpointType, imageName: String, completiong: @escaping((UIImage?) -> Void)) {
        let resource = APIManager.getResource(type: endpointType, imageName: imageName)

        guard let imageURL = URL(string: resource) else {
            completiong(nil)
            return
        }

        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL, timeoutInterval: 15)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                completiong(image)
            }
        } else {
            AF.request(imageURL, method: .get)
                .validate()
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            if let urlResponse = response.response, urlResponse.statusCode < 300,
                                let image = UIImage(data: data) {
                                let cachedData = CachedURLResponse(response: urlResponse, data: data)
                                cache.storeCachedResponse(cachedData, for: request)

                                DispatchQueue.main.async {
                                    completiong(image)
                                }
                            } else {
                                completiong(nil)
                            return
                            }
                        case .failure(let err):
                            print("Error: ", err)
                            completiong(nil)
                    }
            }
        }
    }
    
}

extension URLRequest {
    
    static func loadJSON<T>(resource: Resource<T>) -> Observable<APIManager.ApiResult<T>> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                var request = URLRequest(url: url)
                request.method = .get
                request.setValue("TechTeam", forHTTPHeaderField:"User-Agent")
                return URLSession.shared.rx.response(request: request)
            }.map { (reponse, data) -> APIManager.ApiResult<T> in
                switch reponse.statusCode {
                    case 200...300:
                        return APIManager.ApiResult.success(try JSONDecoder().decode(T.self, from: data))
                    case 400...499:
                        return APIManager.ApiResult.failure(.authorizationError)
                    case 500...599:
                        return APIManager.ApiResult.failure(.serverError)
                    default:
                        return APIManager.ApiResult.failure(.authorizationError)
                }
            }
    }

}
