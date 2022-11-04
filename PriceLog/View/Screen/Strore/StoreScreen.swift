//
//  StoreScreen.swift
//  PriceLog
//
//  Created by William Santoso on 01/11/22.
//

import SwiftUI

struct StoreScreen: View {
    @StateObject private var viewModel = StoreScreenViewModel()
    var body: some View {
        Form {
            Section {
                TextFieldLabel(label: "Name", promp: "Superindo", text: $viewModel.name)
                
                Button("Save") {
                    viewModel.saveStore()
                }
            }
            
            Section {
                List {
                    ForEach(viewModel.storesVM) { storeVM in
                        Text(storeVM.store.name)
                    }
                    .onDelete { offsets in
                        viewModel.deleteStore(at: offsets)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getStoreCD()
        }
        .refreshable {
            viewModel.getStoreCD()
        }
        .navigationTitle("Store")
        .toolbar {
            EditButton()
        }
    }
}

struct StoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StoreScreen()
        }
    }
}
