//
//  MainViewModel.swift
//  SideDish-SwiftUI
//
//  Created by 박진섭 on 2022/08/11.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    private let networkManager: NetworkService
    var bag = Set<AnyCancellable>()
    
    @Published var mainMenus: [Menu] = []
    @Published var soupMenus: [Menu] = []
    @Published var sideMenus: [Menu] = []
    
    init(networkService: NetworkService = NetworkManager())  {
        self.networkManager = networkService
    }
    
    func fetchData() {
        Category.allCases.forEach { category in
            networkManager.fetchData(type: Menus.self, endpoint: EndPointCase.get(category: category).endpoint)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("data fetch finished(main)")
                        
                    case .failure(let error):
                        print("\(error) occured!")
                    }
                } receiveValue: { [weak self] menus in
                    switch category {
                    case .main:
                        self?.mainMenus.append(contentsOf: menus.body)
                    case .soup:
                        self?.soupMenus.append(contentsOf: menus.body)
                    case .side:
                        self?.sideMenus.append(contentsOf: menus.body)
                    }
            }
                .store(in: &bag)
        }
    }
}

