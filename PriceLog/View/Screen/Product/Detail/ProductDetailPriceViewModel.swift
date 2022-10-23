//
//  ProductDetailPriceViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductDetailPriceViewModel: ObservableObject {
    @Published var prices: [Price] = pricesMock
}
