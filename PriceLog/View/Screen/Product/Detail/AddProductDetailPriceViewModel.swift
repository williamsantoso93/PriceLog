//
//  AddProductDetailPriceViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class AddProductDetailPriceViewModel: ObservableObject {
    var price: Price?
    
    @Published var priceString: String = ""
    private var priceValue: Double {
        priceString.toDouble() ?? 0
    }
    
    @Published var locationSelection: Int = 0
    //TODO: change to actual data
    let locations: [String] = [
        "Superindo",
        "Indomaret"
    ]
    
    @Published var date: Date = Date()
    
    var isEdit: Bool = false
    
    init(price: Price? = nil) {
        if let price = price {
            self.price = price
            self.priceString = price.value.splitDigit(maximumFractionDigits: 2)
            self.date = price.date
            
            if let locationIndex = locations.firstIndex(where: { location in
                location.lowercased() == price.place.name.lowercased()
            }) {
                self.locationSelection = locationIndex
            }
            
            isEdit = true
        } else {
            self.price = Price()
        }
    }
    
    func save(completion: (Price?) -> Void) {
        if !priceString.isEmpty {
            price?.value = priceValue
            price?.date = date
            price?.updatedDate = Date()
            
            //TODO: Temp place
            price?.place = Place(name: locations[locationSelection])
            
            //TODO: save action
            completion(price)
        }
    }
}
