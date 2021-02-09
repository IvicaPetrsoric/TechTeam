//
//  APIManager.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import Foundation
import UIKit

struct Resource {
    let url: String
}

class APIManager {
    
    static let baseUrl = "https://teltech.co"
    
    enum ApiResult<T> {
        case success(T)
        case failure(RequestError)
    }
    
    enum EndpointType {
        case getBaseDescription
        case getImage
    }
    
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

    static private func getResource(type: EndpointType, imageName: String = "") -> Resource{
        switch type {

        case .getBaseDescription:
            return Resource(url: "\(APIManager.baseUrl)/teltechiansFlat.json")

        case .getImage:
            return Resource(url: "\(APIManager.baseUrl)/images/members/\(imageName).jpg")
        }
    }
    
    static func requestData<T: Decodable>(endpointType: EndpointType, decodeType: T.Type, completion: @escaping (ApiResult<T>)->Void) {
        let resource = APIManager.getResource(type: endpointType)
        guard let url = URL(string: resource.url) else { return completion(ApiResult.failure(.invalidURL)) }
        let request = URLRequest(url: url, timeoutInterval: 15)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    let responseJson = try JSONDecoder().decode(T.self, from: data)
                    print("responseCode : \(responseCode.statusCode)")
//                    print("responseJSON : \(responseJson)")
                    switch responseCode.statusCode {
                    case 200:
                    completion(ApiResult.success(responseJson))
                    case 400...499:
                    completion(ApiResult.failure(.authorizationError))
                    case 500...599:
                    completion(ApiResult.failure(.serverError))
                    default:
                        completion(ApiResult.failure(.unknownError))
                        break
                    }
                }
                catch let parseJSONError {
                    completion(ApiResult.failure(.unknownError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
        }.resume()
    }

    static func loadImage(endpointType: EndpointType, imageName: String, completiong: @escaping((UIImage?) -> Void)) {
        let resource = APIManager.getResource(type: endpointType, imageName: imageName)

        guard let imageURL = URL(string: resource.url) else {
            completiong(nil)
            return
        }

        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL, timeoutInterval: 15)

        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completiong(image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)

                        DispatchQueue.main.async {
                            completiong(image)
                        }
                    } else {
                        completiong(nil)
                        return
                    }
                }).resume()
            }
        }
    }
    
}
