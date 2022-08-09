//
//  DetailView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/09.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel = DetailViewModel()
    @State var id: String
    var body: some View {
        NavigationView {
            
        }.onAppear {
            viewModel.fetchOnbanDetail(id: id)
        }
    }
}
