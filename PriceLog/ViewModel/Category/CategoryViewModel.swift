//
//  CategoryViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = categoriesMock
}
