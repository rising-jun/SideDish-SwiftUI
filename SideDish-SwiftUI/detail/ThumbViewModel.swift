//
//  ThumbViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/10.
//

import Foundation
import Combine

final class ThumbViewModel: ObservableObject {
    var imageURLs: [String]
    
    @Published var imageData = [Data]()
    init(imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
    
    func fetchThumbImages() {
        let urls = imageURLs
            .map { URL(string: $0) }
            .compactMap { $0 }
        
        for url in urls {
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global())
                .map { $0.data }
                .replaceError(with: Data())
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    guard let self = self else { return }
                    self.imageData.append(data)
                }
        }
    }
}
