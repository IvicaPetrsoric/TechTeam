//
//  APIManager.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import Foundation
import UIKit
import Alamofire

struct Resource {
    let url: String
}

class APIManager {
    
    static let baseUrl = "https://www.cleanappcode.com/testing/teach_team"
    
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

    /// prepare rosurce for specific endpoint
    static private func getResource(type: EndpointType, imageName: String = "") -> Resource{
        switch type {

        case .getBaseDescription:
            return Resource(url: "\(APIManager.baseUrl)/api/getEmployeesData")

        case .getImage:
            return Resource(url: "\(APIManager.baseUrl)/resource/\(imageName).jpg")
        }
    }
    
    static func getResource2(type: EndpointType, imageName: String = "") -> String{
        switch type {

        case .getBaseDescription:
            return "\(APIManager.baseUrl)/api/getEmployeesData"

        case .getImage:
            return "\(APIManager.baseUrl)/resource/\(imageName).jpg"
        }
    }
    
    /// fetch data from specific endpoint, if error return error enum
    static func requestData<T: Decodable>(endpointType: EndpointType, decodeType: T.Type,
                                          completion: @escaping (ApiResult<T>) -> Void) {
        let resource = APIManager.getResource(type: endpointType)
        print("URL \(resource.url)")

        guard let url = URL(string: resource.url) else {
            return completion(ApiResult.failure(.invalidURL))
        }
               
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        if let responseCode = response.response?.statusCode {
                            let responseJson = try JSONDecoder().decode(T.self, from: data)
                            print("responseCode : \(responseCode)")

                            switch responseCode {
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
                        } else {
                            completion(ApiResult.failure(.unknownError))
                            print("Error fetch status code nil")
                        }
                    }
                    catch let parseJSONError {
                        completion(ApiResult.failure(.unknownError))
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                case .failure(let error):
                    print(error)
                    completion(ApiResult.failure(.connectionError))
                }
            }
    }

    /// load image from endpoint and save it inside shared cache
    static func loadImage(endpointType: EndpointType, imageName: String, completiong: @escaping((UIImage?) -> Void)) {
        let resource = APIManager.getResource(type: endpointType, imageName: imageName)

        guard let imageURL = URL(string: resource.url) else {
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
                            if let urlResponse = response.response,
                            urlResponse.statusCode < 300,
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

