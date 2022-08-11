//
//  MainHeaderView.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/11.
//

import SwiftUI

struct MainHeaderView: View {
    
    let headerText: String
    
    var body: some View {
        Text("\(headerText)")
            .foregroundColor(.black)
            .font(.system(size: 32))
            .lineLimit(2)
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(headerText: "모두가 좋아하는\n든든한 메인 요리")
    }
}
