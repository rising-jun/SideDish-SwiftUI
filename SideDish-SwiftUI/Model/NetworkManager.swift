//
//  NetworkManager.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/11.
//

import Foundation
import Combine

protocol NetworkService {
    func fetchData<T: Decodable>(type: T.Type, endpoint: Endpoint) -> AnyPublisher<T, Error>
}

struct NetworkManager: NetworkService {

    var session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<T>(type: T.Type,
                      endpoint: Endpoint) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = endpoint.httpMethod.description
        
        endpoint.headers?.forEach{ urlRequest.setValue($1 as? String, forHTTPHeaderField: $0)}
  
        return session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder()) // decodeType 정의
            .eraseToAnyPublisher()  // AnyPublisher로 변경
    }
}


