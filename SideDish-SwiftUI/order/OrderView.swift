//
//  ContentView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import SwiftUI

struct OrderView: View {
    
    @ObservedObject var viewModel = OnbanViewModel()
    init() {
        UITableView.appearance().backgroundColor = .white
    }
    var body: some View {
        NavigationView {
            ZStack() {
                List {
                    ForEach(viewModel.keys, id: \.self) { key in
                        Section {
                            if let onban = viewModel.onbanData[key] {
                                ForEach(onban.body, id: \.self) { menu in
                                    NavigationLink(destination: DetailView(id: menu.detail_hash, menu: menu)) {
                                        OnbanContentView(onban: menu)
                                    }.padding(.bottom, 10)
                                }
                            }
                        } header: {
                            OnbanHeaderView(title: key.title())
                        }.background(Color.white)
                            .listRowInsets(EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 0))
                    }
                }
            }
            .navigationTitle("Ordering")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
            .background(Color.white)
            .onAppear {
                viewModel.fetchOnbanCategory()
            }
    }
}

struct OnbanHeaderView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 35))
                .foregroundColor(.black)
                .padding()
            Spacer()
        }
    }
}

struct OnbanContentView: View {
    @State var onban: Menu
    @ObservedObject var contentViewModel = OnbanContentViewModel()
    
    var body: some View {
        ZStack {
            HStack {
                Image(uiImage: UIImage(data: contentViewModel.imageData) ?? UIImage())
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .padding(.trailing, 5)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(onban.title)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .padding(.bottom, 8)
                    Text(onban.description)
                        .lineLimit(1)
                        .font(.system(size: 15,weight: .light, design: .default))
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    HStack {
                        Text(onban.s_price ?? "nil")
                            .font(.system(size: 15,weight: .bold, design: .default))
                        Text("~\(onban.n_price ?? "")~")
                            .font(.system(size: 15))
                    }.padding(.bottom, 8)
                    HStack {
                        ForEach(onban.badge ?? [], id: \.self) { badge in
                            if let badgeType = BadgeType(rawValue: badge) {
                                BadgeView(badgeType: badgeType)
                            }
                        }
                    }
                }
            }
        }.onAppear {
            contentViewModel.fetchImage(from: onban.image)
        }
        
    }
}

struct BadgeView: View {
    var badgeType: BadgeType
    init(badgeType: BadgeType) {
        self.badgeType = badgeType
    }
    var body: some View {
        switch badgeType {
        case .launching:
            ZStack(alignment: .center) {
                Text(badgeType.text)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            }
            .background(Color.blue)
            .cornerRadius(15)
            
        case .event:
            ZStack(alignment: .center) {
                Text(badgeType.text)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            }
            .background(Color.green)
            .cornerRadius(15)
        case .main:
            Text("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

enum BadgeType: String {
    case launching = "런칭특가"
    case event = "이벤트특가"
    case main = "메인특가"
    
    var text: String {
        return self.rawValue
    }
}
