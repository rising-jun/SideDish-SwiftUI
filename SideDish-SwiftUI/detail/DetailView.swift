//
//  DetailView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/09.
//

import SwiftUI

struct DetailView: View {
    init(id: String, menu: Menu) {
        viewModel = DetailViewModel(id: id)
        self.menu = menu
        self.count = 1
    }
    @ObservedObject var viewModel: DetailViewModel
    @State var menu: Menu
    @State var count: Int
    var body: some View {
        GeometryReader { p in
            ScrollView {
                ZStack {
                    VStack(alignment: .leading) {
                        if let menuDetail = viewModel.menuDetail {
                            DetailThumbImages(thumbViewModel: ThumbViewModel(imageURLs: menuDetail.thumb_images))
                                .frame(width: p.size.width, height: p.size.width, alignment: .top)
                        }
                        Text(menu.title)
                            .lineLimit(1)
                            .font(.system(size: 30, weight: .medium, design: .default))
                            .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
                        Text(menu.description)
                            .lineLimit(1)
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(Color.gray)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        
                        HStack {
                            Text(menu.s_price ?? "")
                                .lineLimit(1)
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                            Text("~\(menu.n_price ?? "")~")
                                .lineLimit(1)
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            ForEach(menu.badge ?? [], id: \.self) { badge in
                                if let badgeType = BadgeType(rawValue: badge) {
                                    BadgeView(badgeType: badgeType)
                                        .padding(.leading, 10)
                                }
                            }
                        }.padding(.bottom)
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("적립금")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 20))
                                Text(viewModel.menuDetail?.point ?? "0원")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 20))
                            }
                            
                            HStack {
                                Text("배송정보")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 20))
                                Text(viewModel.menuDetail?.delivery_info ?? "없음")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 5, trailing: 20))
                            }
                            
                            HStack {
                                Text("배송비")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 20))
                                Text(viewModel.menuDetail?.delivery_fee ?? "0원")
                                    .font(.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 20))
                            }.padding(.bottom)
                            Divider()
                            
                            ZStack {
                                HStack {
                                    Text("수량")
                                        .font(.system(size: 15, weight: .medium, design: .default))
                                        .foregroundColor(.gray)
                                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 5))
                                    Spacer()
                                    Text("\(viewModel.count)")
                                        .font(.system(size: 15, weight: .medium, design: .default))
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 5))
                                    plusMinusButton(buttonTapped: viewModel.buttonTapped)
                                        .padding()
                                }
                            }
                            Divider()
                            
                            HStack(alignment: .center, spacing: 10, content: {
                                Spacer()
                                Text("총 주문 금액")
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                    .foregroundColor(.gray)
                                    .padding()
                                
                                Text(viewModel.price)
                                    .font(.system(size: 22, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding()
                            })
                        }
                    }
                }
            }
        }
        .navigationTitle(menu.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchOnbanDetail()
        }
    }
}

struct plusMinusButton: View {
    var buttonTapped: ((ButtonKind) -> ())
    init(buttonTapped: @escaping (ButtonKind) -> ()) {
        self.buttonTapped = buttonTapped
    }
    var body: some View {
        ZStack {
            HStack {
                Button("-") {
                    buttonTapped(.minus)
                }.frame(width: 50, height: 35, alignment: .center).background(Color.gray)
                    .foregroundColor(.black)
                    .padding(.trailing, 2)
                Button("+") {
                    buttonTapped(.plus)
                }.frame(width: 50, height: 35, alignment: .center).background(Color.gray)
                    .foregroundColor(.black)
                    .padding(.trailing, 5)
            }
        }
    }
}

struct DetailThumbImages: View {
    @StateObject var thumbViewModel: ThumbViewModel
    
    var body: some View {
        ZStack {
            if thumbViewModel.imageData.count > 0 {
                TabView {
                    ForEach(thumbViewModel.imageData, id: \.self) { data in
                        HStack {
                            Image(uiImage: UIImage(data: data) ?? UIImage())
                                .resizable()
                        }
                    }
                } .tabViewStyle(PageTabViewStyle())
            }
        }.onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .blue
            thumbViewModel.fetchThumbImages()
        }
    }
}

enum ButtonKind {
    case plus
    case minus
}
