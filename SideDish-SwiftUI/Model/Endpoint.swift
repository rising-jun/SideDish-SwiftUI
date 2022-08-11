//
//  Endpoint.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/11.
//

import Foundation

struct Endpoint {
    let httpMethod: HTTPMethod
    let baseURL: BaseURL
    let path: Path
    let headers: [String: Any]?
    let body: [String: Any]?
    
    init(httpMethod: HTTPMethod, baseURL: BaseURL, path: Path, headers: [String: Any]? = ["Content-Type": "application/json"], body: [String: Any]? = nil) {
        self.httpMethod = httpMethod
        self.baseURL = baseURL
        self.path = path
        self.headers = headers
        self.body = body
    }
}

extension Endpoint {
    var url: URL {
        let path = self.path.pathString
        let baseURL = self.baseURL.urlString
        
        guard let url = URL(string: baseURL + path) else {
            return URL(string: "URL: fail")!
        }
        
        return url
    }
}


enum EndPointCase {
    case get(category: Category)
    case getDetail(hash: String)
    
    var endpoint: Endpoint {
        switch self {
        case .get(let category):
            return Endpoint(httpMethod: .get,
                            baseURL: .main,
                            path: .get(category: category),
                            body: nil)
            
        case .getDetail(let hash):
            return Endpoint(httpMethod: .get,
                            baseURL: .main,
                            path: .getDetail(hash: hash),
                            body: nil)
        }
    }
}


enum BaseURL {
    case main
    
    var urlString: String {
        switch self {
        case .main:
            return "https://api.codesquad.kr/onban/"
        }
    }
}

enum Path {
    case get(category: Category)
    case getDetail(hash: String)
    
    var pathString: String {
        switch self {
        case .get(let category):
            return "\(category)"
        case .getDetail(let hash):
            return "detail/\(hash)"
        }
    }
}

enum Category: CaseIterable {
    case main
    case soup
    case side
    
    var title: String  {
        switch self {
        case .main:
            return "모두가 좋아하는\n든든한 메인 요리"
        case .soup:
            return "정성이 담긴\n뜨끈뜨끈 국물 요리"
        case .side:
            return "식탁을 풍성하게\n하는 정갈한 밑반찬"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case transportError(Error)
    case encodingError
    case decodingError
    case emptyData
    case emptyLocation
    case otherError(Error)
}

enum HTTPMethod: String, CustomStringConvertible {
    case get
    case post
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
