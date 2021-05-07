//
//  import RxSwift import RxCocoa.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 06/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource2<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource2<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                var request = URLRequest(url: url)
                request.method = .get
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                try request.validate()
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
}
