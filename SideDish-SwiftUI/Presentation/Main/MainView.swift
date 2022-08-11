//
//  ContentView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var sideDishInfo: Menus = MockData.sideDishInfo
    
    var body: some View {
        NavigationView {
            List() {
                // main
                Section {
                    ForEach(viewModel.mainMenus) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    MainHeaderView(headerText: Category.main.title)
                }
                // soup
                Section {
                    ForEach(viewModel.soupMenus) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    MainHeaderView(headerText: Category.soup.title)
                }
                // side
                Section {
                    ForEach(viewModel.sideMenus) { menu in
                        MainViewCell(menu: menu)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    MainHeaderView(headerText: Category.side.title)
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


