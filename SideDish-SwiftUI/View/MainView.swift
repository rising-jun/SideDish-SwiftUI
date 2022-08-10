//
//  ContentView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import SwiftUI

struct MainView: View {
    
    var sideDishInfo: SideDishInfo = MockData.sideDishInfo
    
    var body: some View {
        NavigationView {
            List() {
                Section {
                    ForEach(sideDishInfo.body) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("모두가 좋아하는 든든한 메인 요리")
                }

                Section {
                    ForEach(sideDishInfo.body) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("정성이 담긴 뜨끈뜨끈 국물 요리")
                }
                Section {
                    ForEach(sideDishInfo.body) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("식탁을 풍성하게 하는 정갈한 밑반찬")
                }                
            }
            .listStyle(.plain)
            .navigationTitle("Ordering")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
