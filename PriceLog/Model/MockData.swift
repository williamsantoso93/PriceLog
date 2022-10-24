//
//  MockData.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import Foundation

let categoriesMock: [Category] = [
    Category(name: "Cereal", image: "", products: productsMock),
    Category(name: "Drink", image: "", products: productsMock),
    Category(name: "Oil", image: "", products: productsMock),
    Category(name: "Sauce", image: "", products: productsMock),
]

let productsMock: [Product] = [
    Product(name: "Coco Crunch", image: "", types: productTypesMock),
    Product(name: "Milo", image: "", types: productTypesMock),
    Product(name: "Honey Star", image: "", types: productTypesMock),
    Product(name: "Corn Flex", image: "", types: productTypesMock)
]

let productTypesMock: [ProductType] = [
    ProductType(name: "Kecil", image: "", unit: 200, unitType: .g, prices: pricesMock[0]),
    ProductType(name: "Sedang", image: "", unit: 300, unitType: .kg, prices: pricesMock[1]),
    ProductType(name: "Besar", image: "", unit: 400, unitType: .l, prices: pricesMock[2]),
]

let pricesMock: [[Price]] = [
    [
        Price(createdDate: Date(), updatedDate: Date(), place: Place(name: "Indomaret"), value: 20000),
        Price(createdDate: Date(), updatedDate: Date(), place: Place(name: "Super Indo"), value: 22500),
        Price(createdDate: Date(), updatedDate: Date(), place: Place(name: "Food Hall"), value: 21000),
    ],
    [
        Price(createdDate: Date(), updatedDate: Date(), place: Place(name: "Food Hall"), value: 21000),
        Price(createdDate: Date(), updatedDate: Date(), place: Place(name: "Super Indo"), value: 22500),
    ],
    [
        Price(createdDate: Date(), updatedDate: Date(), place: Place(name: "Super Indo"), value: 22500),
    ],
]
