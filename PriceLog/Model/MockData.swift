//
//  MockData.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import Foundation

let categoriesMock: [Category] = [
    Category(name: "Cereal", products: productsMock),
    Category(name: "Drink", products: productsMock),
    Category(name: "Oil", products: productsMock),
    Category(name: "Sauce", products: productsMock),
]

let productsMock: [Product] = [
    Product(name: "Coco Crunch", types: productTypesMock),
    Product(name: "Milo", types: productTypesMock),
    Product(name: "Honey Star", types: productTypesMock),
    Product(name: "Corn Flex", types: productTypesMock)
]

let productTypesMock: [ProductType] = [
    ProductType(name: "Kecil", unit: 200, unitType: .g, prices: pricesMock[0]),
    ProductType(name: "Sedang", unit: 300, unitType: .kg, prices: pricesMock[1]),
    ProductType(name: "Besar", unit: 400, unitType: .l, prices: pricesMock[2]),
    ProductType(name: "Besar", unit: 450.05, unitType: .l, prices: pricesMock[2]),
]

let pricesMock: [[ProductPrice]] = [
    [
        ProductPrice(createdAt: "01/10/2022".toDate(format: "dd/MM/yyyy")!, updatedAt: "02/10/2022".toDate(format: "dd/MM/yyyy")!, store: Store(name: "Indomaret"), value: 20000, date: "02/10/2022".toDate(format: "dd/MM/yyyy")!),
        ProductPrice(createdAt: "01/10/2022".toDate(format: "dd/MM/yyyy")!, updatedAt: "03/10/2022".toDate(format: "dd/MM/yyyy")!, store: Store(name: "Super Indo"), value: 22500, date: "03/10/2022".toDate(format: "dd/MM/yyyy")!),
        ProductPrice(createdAt: "01/10/2022".toDate(format: "dd/MM/yyyy")!, updatedAt: "04/10/2022".toDate(format: "dd/MM/yyyy")!, store: Store(name: "Food Hall"), value: 21000, date: "04/10/2022".toDate(format: "dd/MM/yyyy")!),
    ],
    [
        ProductPrice(createdAt: "01/10/2022".toDate(format: "dd/MM/yyyy")!, updatedAt: "02/10/2022".toDate(format: "dd/MM/yyyy")!, store: Store(name: "Food Hall"), value: 21000, date: "02/10/2022".toDate(format: "dd/MM/yyyy")!),
        ProductPrice(createdAt: "01/10/2022".toDate(format: "dd/MM/yyyy")!, updatedAt: "03/10/2022".toDate(format: "dd/MM/yyyy")!, store: Store(name: "Super Indo"), value: 22500, date: "03/10/2022".toDate(format: "dd/MM/yyyy")!),
    ],
    [
        ProductPrice(createdAt: "01/10/2022".toDate(format: "dd/MM/yyyy")!, updatedAt: "04/10/2022".toDate(format: "dd/MM/yyyy")!, store: Store(name: "Super Indo"), value: 22500, date: "04/10/2022".toDate(format: "dd/MM/yyyy")!),
    ],
]
