//
//  ImageManager.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import Combine
import Foundation

final class ImageManager {
    static let shared = ImageManager()
    private init() { }
    func fetchImage(from url: String) -> AnyPublisher<Data, Never> {
        guard let url = URL(string: url) else {
            return AnyPublisher.init(Just(Data())) }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .map { $0.data }
            .replaceError(with: Data())
            .eraseToAnyPublisher()
    }
}
