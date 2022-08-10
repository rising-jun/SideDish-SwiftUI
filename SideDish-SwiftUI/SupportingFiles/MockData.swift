//
//  MockSideDishInfo.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/10.
//

import Foundation

struct MockData {
    static let sideDishInfo: SideDishInfo =  SideDishInfo(body: [Menu(id: "HBDEF",
                                                                        image: "http://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg",
                                                                        delivery_type:  [
                                                                           "새벽배송",
                                                                           "전국택배"
                                                                        ],
                                                                        title: "오리 주물럭_반조리",
                                                                        description: "감칠맛 나는 매콤한 양념",
                                                                        n_price: "15,800원",
                                                                        s_price: "12,640원",
                                                                        badge: [
                                                                           
                                                                        ]),
                                                                 Menu(id: "HDF73",
                                                                        image: "http://public.codesquad.kr/jk/storeapp/data/main/310_ZIP_P_0012_T.jpg",
                                                                        delivery_type:  [
                                                                           "새벽배송",
                                                                           "전국택배"
                                                                        ],
                                                                        title: "잡채",
                                                                        description: "탱글한 면발과 맛깔진 고명이 가득",
                                                                        n_price: "12,900원",
                                                                        s_price: "11,610원",
                                                                        badge: [
                                                                           "이벤트특가"
                                                                        ])
                                                                 ,
                                                          Menu(id: "HF778",
                                                                 image: "http://public.codesquad.kr/jk/storeapp/data/main/349_ZIP_P_0024_T.jpg",
                                                                 delivery_type:  [
                                                                    "새벽배송",
                                                                    "전국택배"
                                                                 ],
                                                                 title: "소갈비찜",
                                                                 description: "촉촉하게 밴 양념이 일품",
                                                                 n_price: "28,900원",
                                                                 s_price: "26,010원",
                                                                 badge: [
                                                                    "이벤트특가",
                                                                    "메인특가"
                                                                ])])
    
}
