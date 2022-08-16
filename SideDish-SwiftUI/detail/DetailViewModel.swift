//
//  DetailViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/09.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published private(set) var menuDetail: MenuDetail? {
        didSet {
            price = menuDetail?.prices.last ?? ""
        }
    }
    @Published private(set) var thumbImages: [Data] = []
    @Published private(set) var count: Int = 1 {
        willSet(value) {
            guard let priceString = menuDetail?.prices.last else { return }
            guard var intPrice = Int(priceString.components(separatedBy: ["원",","]).joined()) else { return }
            intPrice = intPrice * value
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            guard var formatted = numberFormatter.string(from: NSNumber(value: intPrice)) else { return }
            formatted += "원"
            self.price = formatted
        }
    }
    @Published private(set) var price: String = ""
    
    private let id: String
    init(id: String) {
        self.id = id
    }
    
    lazy var buttonTapped: ((ButtonKind) -> ()) = { [weak self] kind in
        guard let self = self else { return }
        switch kind {
        case .plus:
            self.count += 1
        case .minus:
            self.count -= 1
        }
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
}
