//
//  OnbanRepository.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import Foundation
import Combine

final class OnbanRepository: ObservableObject {
    @Published private(set) var onbanData: [DishCategory: Onban] = [:]  {
        willSet {
            print(onbanData)
        }
    }
    let keys: [DishCategory] = [.main, .soup, .side]
    
    private var dataCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    deinit {
        dataCancellable?.cancel()
    }
    
    func fetchOnbanCategory() {
        guard let mainUrl = URL(string: "https://api.codesquad.kr/onban/main") else { return }
        guard let soupUrl = URL(string: "https://api.codesquad.kr/onban/soup") else { return }
        guard let sideUrl = URL(string: "https://api.codesquad.kr/onban/side") else { return }
        
        let mainOnbanPublisher = URLSession.shared.dataTaskPublisher(for: mainUrl)
            .subscribe(on: RunLoop.current)
            .map { $0.data }
            .decode(type: Onban.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        let soupOnbanPublisher = URLSession.shared.dataTaskPublisher(for: soupUrl)
            .subscribe(on: RunLoop.current)
            .map { $0.data }
            .decode(type: Onban.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        let sideOnbanPublisher = URLSession.shared.dataTaskPublisher(for: sideUrl)
            .subscribe(on: RunLoop.current)
            .map { $0.data }
            .decode(type: Onban.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            
        dataCancellable = Publishers.Zip3(mainOnbanPublisher, soupOnbanPublisher, sideOnbanPublisher)
            .map { main, soup, side -> [DishCategory: Onban] in
                var onbans = [DishCategory: Onban]()
                onbans[.main] = main
                onbans[.soup] = soup
                onbans[.side] = side
                return onbans
            }
            .replaceError(with: [:])
            .receive(on: DispatchQueue.main)
            .assign(to: \.onbanData, on: self)
    }
    
}

enum DishCategory {
    case main
    case soup
    case side
    
    func title() -> String {
        switch self {
        case .main:
            return "모두가 좋아하는 든든한 메인 요리"
        case .soup:
            return "정성이 담긴 뜨끈뜨끈 국물 요리"
        case .side:
            return "식탁을 풍성하게 하는 정갈한 밑반찬"
        }
    }
}
