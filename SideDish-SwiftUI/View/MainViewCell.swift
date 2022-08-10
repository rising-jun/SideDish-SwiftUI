//
//  MainViewCell.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/10.
//

import SwiftUI
import Kingfisher

struct MainViewCell: View {
    
    let menu: Menu
    
    var body: some View {
        HStack {
            KFImage(URL(string: menu.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                
            VStack(alignment: .leading, spacing: 5.0) {
                
                Text(menu.title)
                    .fontWeight(.bold)
                
                Text(menu.description)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                HStack() {
                    Text(menu.s_price ?? "")
                    Text(menu.n_price ?? "")
                        .strikethrough()
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                
                Spacer().frame(height: 8)

                HStack {
                ForEach(menu.badge ?? [] , id: \.self) { badge in
                    Text(badge)
                        .padding(EdgeInsets(top: 4,
                                            leading: 16,
                                            bottom: 4,
                                            trailing: 16))
                        .background(Color.blue)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                    }
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                }
            }
        }
        .lineSpacing(8)
        .background(Color.yellow)
    }
}

struct MainViewCell_Previews: PreviewProvider {
    static var previews: some View {
        MainViewCell(menu: MockData.sideDishInfo.body[0])
    }
}
