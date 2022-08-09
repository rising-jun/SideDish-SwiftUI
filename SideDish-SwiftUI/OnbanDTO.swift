//
//  OnbanDTO.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import Foundation

struct Onban: Codable {
    let statusCode: Int
    let body: [Menu]
}

struct Menu: Codable, Hashable {
    let detail_hash: String
    let image: String
    let alt: String
    let delivery_type: [String]
    let title: String
    let description: String
    let n_price: String?
    let s_price: String?
    let badge: [String]?
}

struct DetailDishInfo: Codable {
    let data: MenuDetail
    
    func convertEntity() -> DetailDishEntity {
        return DetailDishEntity(data: data)
    }
}

class DetailDishEntity {
    init(data: MenuDetail?) {
        self.data = data
    }
    let data: MenuDetail?
}

struct MenuDetail: Codable {
    let top_image: String
    let thumb_images: [String]
    let product_description: String
    let point: String
    let delivery_info: String
    let delivery_fee: String
    let prices: [String]
    let detail_section: [String]
}
