//
//  ImageManager.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import Foundation

final class ImageManager {
    static let shared = ImageManager()
    private init() { }
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data ,response , error in
            guard let data = data else { return }
            completion(data)
        }
    }
}
