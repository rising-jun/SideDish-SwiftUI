//
//  MainViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/11.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var mainMenus: [Menu] = []
    @Published var sideMenus: [Menu] = []
    @Published var soupMenus: [Menu] = []
    
    func fetchData() {
        
    }
    
}

