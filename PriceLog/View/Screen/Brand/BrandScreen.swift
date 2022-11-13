//
//  BrandScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct BrandScreen: View {
    @StateObject private var viewModel = BrandScreenViewModel()
    @State private var isShowAddBrand: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns, alignment: .leading) {
                    ForEach(viewModel.brandsVM.indices, id: \.self) { index in
                        let brandVM = viewModel.brandsVM[index]
                        
                        NavigationLink {
                            ProductScreen(viewModel: ProductScreenViewModel(brandVM: brandVM))
                        } label: {
                            CategoryCellView(
                                title: brandVM.brand.name,
                                onEdit: {
                                    viewModel.selectedBrandIndex = index
                                    isShowAddBrand.toggle()
                                }, onDelete: {
                                    viewModel.selectedBrandIndex = index
                                    viewModel.deleteBrand(by: brandVM.id)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .onAppear {
                viewModel.getBrandsCD()
            }
            .refreshable {
                viewModel.getBrandsCD()
            }
            .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
            .navigationTitle("Brand")
            .sheet(isPresented: $isShowAddBrand, onDismiss: {
                viewModel.selectedBrandIndex = nil
                viewModel.getBrandsCD()
            }) {
                AddBrandScreen(
                    viewModel: AddBrandViewModel(brandVM: viewModel.selectedBrandVM),
                    onSave: {
                    },
                    onDelete: {
                        if let id = viewModel.selectedBrandVM?.id {
                            viewModel.deleteBrand(by: id)
                        }
                    }
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        isShowAddBrand.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        viewModel.deleteAll()
//                    } label: {
//                        Text("Delete All")
//                    }
//                }
            }
        }
    }
}

struct BrandScreen_Previews: PreviewProvider {
    static var previews: some View {
        BrandScreen()
    }
}

