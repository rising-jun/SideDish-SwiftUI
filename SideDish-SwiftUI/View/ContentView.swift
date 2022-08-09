//
//  ContentView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sideDishInfo:[SideDishInfo]
    
    
    var body: some View {
        List(sideDishInfo) {_ in
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sideDishInfo: [SideDishInfo(body: [Me])])
    }
}
