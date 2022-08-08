//
//  ContentView.swift
//  SideDish-SwiftUI
//
//  Created by 김동준 on 2022/08/08.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = OnbanRepository()
    
    var body: some View {
        NavigationView {
            ZStack() {
                List {
                    ForEach(viewModel.keys, id: \.self) { key in
                        Section {
                            if let onban = viewModel.onbanData[key] {
                                
                                ForEach(onban.body, id: \.self) { menu in
                                    OnbanContentView(onban: menu)
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
                    }.listStyle(GroupedListStyle())
                }
            }
            .navigationTitle("Ordering")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
            .onAppear {
                viewModel.fetchOnbanCategory()
            }
    }
}

struct OnbanHeaderView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title).font(.system(size: 35)).foregroundColor(.black).padding()
            Spacer()
        }
    }
}

struct OnbanContentView: View {
    @State var onban: Menu
    var body: some View {
        ZStack {
            HStack {
                Image("asdf").frame(width: 120, height: 120, alignment: .center)
                
                VStack {
                    Text(onban.title).font(.title3)
                    Text(onban.description)
                    Text(onban.n_price ?? "")
                    Button("fuck") {
                        //action
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
