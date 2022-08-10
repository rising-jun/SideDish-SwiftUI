//
//  DetailViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/09.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published private(set) var menuDetail: MenuDetail?
    @Published private(set) var thumbImages: [Data] = []
    private let id: String
    init(id: String) {
        self.id = id
    }
    
    func fetchOnbanDetail() {
        guard let url = URL(string: "https://api.codesquad.kr/onban/detail/\(id)") else { return }
        let meuCancellabel = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .map { $0.data }
            .decode(type: DetailDishInfo.self, decoder: JSONDecoder())
            .map { $0.data }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.menuDetail, on: self)
    }
    
    func fetchThumbImages() {
        
    }
}
