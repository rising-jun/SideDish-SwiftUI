//
//  OnbanContentViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/09.
//

import Foundation
import Combine

final class OnbanContentViewModel: ObservableObject {
    @Published private(set) var imageData = Data()
    private var imageCancellabel: AnyCancellable?
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { return }
        imageCancellabel = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .map { $0.data }
            .replaceError(with: Data())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.imageData, on: self)
        }
    
    deinit {
        imageCancellabel?.cancel()
    }
}
