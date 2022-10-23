//
//  ProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = productsMock
}
