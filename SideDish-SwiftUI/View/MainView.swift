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
                    MainHeaderView(headerText: "모두가 좋아하는\n든든한 메인 요리")
                }

                Section {
                    ForEach(sideDishInfo.body) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    MainHeaderView(headerText: "모두가 좋아하는\n든든한 메인 요리")
                }
                Section {
                    ForEach(sideDishInfo.body) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    MainHeaderView(headerText: "모두가 좋아하는\n든든한 메인 요리")
                }                
            }
            .listStyle(.grouped)
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


