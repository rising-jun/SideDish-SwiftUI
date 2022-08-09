//
//  DetailViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/09.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published private(set) var detailDishEntity = DetailDishEntity(data: nil) {
        didSet {
            print(detailDishEntity.data)
        }
    }
    
    func fetchOnbanDetail(id: String) {
        guard let url = URL(string: "https://api.codesquad.kr/onban/detail/\(id)") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .map { $0.data }
            .decode(type: DetailDishInfo.self, decoder: JSONDecoder())
            .map { $0.convertEntity() }
            .replaceError(with: DetailDishEntity(data: nil))
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.detailDishEntity, on: self)
    }
}
