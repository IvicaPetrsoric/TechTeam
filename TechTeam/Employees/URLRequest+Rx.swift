//
//  URLRequest+Rx.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
//    static func loadImage(url: URL) -> Observable<UIImage?> {
//        return Observable.just(url)
//            .flatMap { url -> Observable<Data> in
//                let request = URLRequest(url: url)
//                return URLSession.shared.rx.data(request: request)
//            }.map { data -> UIImage? in
//                return UIImage(data: data)
//            }
//    }
    
}
