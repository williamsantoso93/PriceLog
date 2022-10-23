//
//  ProductTypeViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductTypeViewModel: ObservableObject {
    @Published var productTypes: [ProductType] = productTypesMock
}
