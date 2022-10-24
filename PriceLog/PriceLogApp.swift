//
//  PriceLogApp.swift
//  PriceLog
//
//  Created by William Santoso on 22/06/22.
//

import SwiftUI

@main
struct PriceLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            CategoryScreen()
//            NavigationStack {
//                ProductTypeScreen(viewModel: ProductTypeViewModel(product: categoriesMock[0].products[0]))
//            }
        }
    }
}
